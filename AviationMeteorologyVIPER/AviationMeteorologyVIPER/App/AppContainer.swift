//
//  AppContainer.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import AviatonMeteorologyAPI
import Utility

let app = AppContainer()

final class AppContainer {
    let metarService = AviationMetarService()
    let tafService = AviationTafService()
    let airportService = AviationAirportService()
    let sunTimesService =  AviationSuntimesService()
    let router = AppRouter()
    let core = CoreLocationHelper()
    
    
}
