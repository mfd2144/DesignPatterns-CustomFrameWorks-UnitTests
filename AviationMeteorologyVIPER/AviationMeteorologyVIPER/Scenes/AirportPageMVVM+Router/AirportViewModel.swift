//
//  AirportPresenter.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//

import Foundation
import AviatonMeteorologyAPI
import Utility



final class AirportViewModel:AirportViewModelProtocol{
   
    
    weak var delegate: AirportViewModelDelegate?

    private let router:AirportRouterProtocol
    private let service: AviationAirportServiceProtocol
    private let locationCore:CoreLocationHelper
    private var distance = 10
    
    
    
    init(service:AviationAirportServiceProtocol,router: AirportRouterProtocol,locationCore:CoreLocationHelper) {
        self.service = service
        self.locationCore = locationCore
        self.router = router
        
        locationCore.delegate = self
    }
    
    
    
    func searchAirports(distance:Int) {
        delegate?.handleOutput(.setLoading(true))
        self.distance = distance
        locationCore.requestActualPoint()
    }
    
    func didSelectAnAirport(for icao: String) {
        router.rootToAirportMetar(for: icao)
    }
   
    
    
}

extension AirportViewModel:CoreLocationUpdateProtocol{
    func handleOutputs(_ output: LocationManagerOutputs) {

        switch output {
        case .returnLocation(lat: let lat, lon: let lon):
            let coordinates = Coordinates(lat, lon)

            service.fetchAirportInformation(icao: [""], coordinates:coordinates , distance: distance) { [weak self ]result in
                guard let self = self else {return}
                self.delegate?.handleOutput(.setLoading(false))
                let title = "Lat:\(String(format: "%.2f", lat))/Lon:\(String(format: "%.2f", lon))"
                self.delegate?.handleOutput(.title(title))
                switch result{
                case.success(let response):
                    let airports = response.results.map(AirportPresentation.init)
                    self.delegate?.handleOutput(.airportsList(airports))
                case .failure(let error):
                    self.delegate?.handleOutput(.loadDidFail(.modelError(error)))
                }
            }
            
        case.didFailWithError(let error):
        delegate?.handleOutput(.loadDidFail(.modelError(error)))
        }
    }
    
    
}




