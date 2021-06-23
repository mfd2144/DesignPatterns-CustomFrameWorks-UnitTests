//
//  RouteBuilder.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 22.06.2021.
//

import UIKit

final class RouteBuilder{
    static func make()->UIViewController{
        let storyBoard = UIStoryboard(name: "RoutePage", bundle: nil)
        guard let viewController = storyBoard.instantiateViewController(identifier: "RoutePageViewController") as? RoutePageViewController else {fatalError()}
        viewController.metarService = app.metarService
        viewController.tafService = app.tafService
        return viewController
    }
}
