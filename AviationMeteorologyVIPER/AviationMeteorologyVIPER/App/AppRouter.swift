//
//  AppRouter.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import UIKit



final class AppRouter{
    var window: UIWindow?
    
     func start(_ scene:UIWindowScene){
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        
        //TabbarController
        let tabControllerBoard = UIStoryboard.init(name: "Tabbar", bundle: nil)
        let tabViewController = tabControllerBoard.instantiateViewController(identifier: "TabbarController")
        
        //Tabbar first controller home page is created
        let homePageNav = (tabViewController as? UITabBarController)?.viewControllers?.first as? UINavigationController
        homePageNav?.pushViewController(HomePageBuilder.make(), animated: false)
        
        //Tabbar second controller suntimes is created
        let sunTimesPageNav = (tabViewController as? UITabBarController)?.viewControllers?[1] as? UINavigationController
        sunTimesPageNav?.pushViewController(SunTİmesPAgeBuilder.make(), animated: false)
   
        //Tabbar third controller airport page is created
        let airportPageNav = (tabViewController as? UITabBarController)?.viewControllers?[2] as? UINavigationController
        airportPageNav?.pushViewController(AirportBuilder.make(), animated: false)
        
        //Tabbar fourth controller airport page is created
        let routePageNav = (tabViewController as? UITabBarController)?.viewControllers?[3] as? UINavigationController
        routePageNav?.pushViewController(RouteBuilder.make(), animated: false)
        
        window?.rootViewController = tabViewController
        window?.makeKeyAndVisible()
    }
}
