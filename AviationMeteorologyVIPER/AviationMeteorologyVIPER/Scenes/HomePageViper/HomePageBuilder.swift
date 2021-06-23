//
//  HomePageBuilder.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import UIKit

final class HomePageBuilder{
    static func make()->UIViewController{
        let storybord = UIStoryboard.init(name: "HomePage", bundle: nil)
        guard let view = storybord.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageView else {fatalError()}
        let interactor = HomePageInteractor(metarService: app.metarService, tafService: app.tafService)
        let router = HomePageRouter(view: view)
        let presenter = HomePagePresenter(interactor: interactor, view: view, router: router)
        view.presenter = presenter
        return view
        
    }
}
