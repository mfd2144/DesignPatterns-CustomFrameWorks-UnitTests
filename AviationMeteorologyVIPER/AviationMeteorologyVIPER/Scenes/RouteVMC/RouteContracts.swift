//
//  RouteContracts.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 22.06.2021.
//

import Foundation


@objc protocol RouteViewProtocol{
    var delegate:RouteViewDelegate? {get set}
    func returnReports(tafMetars: [TafMetarPresentation])
    func setLoading(_ isLoading:Bool)
    func routeError(_ error :Error)
}

@objc protocol RouteViewDelegate:AnyObject{
    func searchRoute(for codes:[String])
    func selectAnAirport(for icao:String)
 
}
