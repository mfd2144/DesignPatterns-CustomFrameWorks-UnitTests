//
//  AirportContacts.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//

import Foundation


//ViewModel

enum AirportViewModelOutputs{
    case airportsList([AirportPresentation])
    case loadDidFail(ErrorContainer)
    case setLoading(Bool)
    case title(String)
}

protocol AirportViewModelProtocol:AnyObject{
    var delegate: AirportViewModelDelegate? {get set}
    func searchAirports(distance:Int)
    func didSelectAnAirport(for icao:String)

}


protocol AirportViewModelDelegate:AnyObject{
    func handleOutput(_ output: AirportViewModelOutputs)
}



//Router

protocol AirportRouterProtocol{
    func rootToAirportMetar(for icao:String)
}


//Router -> Although original MVVM doesn't have a router , I add it because it prevent complexity of view model
