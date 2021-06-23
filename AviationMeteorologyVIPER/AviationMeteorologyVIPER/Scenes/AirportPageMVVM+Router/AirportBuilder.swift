//
//  AirportBuilder.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//

import UIKit


final class AirportBuilder{
    static func make()->UIViewController{
        let storybord = UIStoryboard.init(name: "AirportPage", bundle: nil)
        guard let viewController = storybord.instantiateViewController(withIdentifier: "AirportViewController") as? AirportPageViewController else {fatalError()}
        let router = AirportRouter()
        let viewModel = AirportViewModel(service:app.airportService , router: router, locationCore: app.core)
        viewController.viewModel = viewModel
        return viewController
        
    }
}
