//
//  SunTimesBuilder.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//


import UIKit

final class SunTİmesPAgeBuilder{
    static func make()->UIViewController{
        let storybord = UIStoryboard.init(name: "SunTimes", bundle: nil)
        guard let viewController = storybord.instantiateViewController(withIdentifier: "SunTimesPageViewController") as? SuntimesViewController else {fatalError()}
        let interactor = SunTimesPageInteractor(service: app.sunTimesService)
        let presenter = SunTimesPagePresenter(interactor: interactor, view: viewController)
        viewController.presenter = presenter
        return viewController
        
    }
}
