//
//  HomePageInteractor.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import AviatonMeteorologyAPI
import Utility


final class HomePageInteractor:HomePageInteractorProtocol{
   
   
    
    weak var delegate: HomePageInteractorDelegate?
    private var metarService:AviationMetarServiceProtocol!
    private var tafService:AviationTafServiceProtocol!
    var metar:[Metar] = []
    var taf:[TAF] = []
    
    
    init(metarService:AviationMetarServiceProtocol, tafService: AviationTafServiceProtocol) {
        self.metarService = metarService
        self.tafService = tafService
       
    }
    
    
    
    func searchPressed(for icao: [String]) {
        delegate?.handleOutPut(.setMetarLoading(true))
        delegate?.handleOutPut(.setTafLoading(true))
        
            metarService.fetchMetarReport(icao: icao) { [weak self] result in
                guard let self = self else {return}
                self.delegate?.handleOutPut(.setMetarLoading(false))
                switch result{
                case.success(let metarData):
                    let metars = metarData.results
                    self.metar = metars
                    self.delegate?.handleOutPut(.showMetar(metars))
                case.failure(let error):
                    self.delegate?.handleOutPut(.metarErrorContainer(error))
                }
                
            }
            tafService.fetchTafReport(icao: icao) {  [weak self] result in
                guard let self = self else {return}
                self.delegate?.handleOutPut(.setTafLoading(false))
                switch result{
                case.success(let tafsData):
                    let tafs = tafsData.results
                    self.taf = tafs
                    self.delegate?.handleOutPut(.showTaf(tafs))
                case.failure(let error):
                    self.delegate?.handleOutPut(.metarErrorContainer(error))
                }
            }
        
    }
    
    
    func metarDecodedPressed() {
        guard  let metar = metar.first else { return }
        delegate?.handleOutPut(.showMetarDecoded(metar))
    }
    
    
}

