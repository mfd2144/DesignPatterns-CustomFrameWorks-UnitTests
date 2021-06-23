//
//  HomePageRouter.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import struct AviatonMeteorologyAPI.Metar

final class HomePageRouter:HomePageRouterProtocol{
    unowned let view:HomePageView

    init(view:HomePageView){
        self.view = view
 
    }
    
    func navigateToRoute(_ route: HomePageRouterOutput) {
        switch  route {
        case .decode(let metar):
            let decodedPage = DecodedPageBuilder.make(with: metar)
            view.show(decodedPage, sender:nil)
        }
        
      
    }
    
    
}
