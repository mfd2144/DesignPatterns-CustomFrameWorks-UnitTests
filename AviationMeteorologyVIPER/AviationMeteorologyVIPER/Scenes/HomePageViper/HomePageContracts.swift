//
//  HomePageContracts.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import AviatonMeteorologyAPI


//View

protocol HomePageViewProtocol:AnyObject{
    func handleOutput(_ output: HomePagePresenterOutput)
}

//Intrector

enum HomePageInteractorOutput{
    case setMetarLoading(Bool)
    case setTafLoading(Bool)
    case showMetar([Metar])
    case showTaf([TAF])
    case tafErrorContainer(Error)
    case metarErrorContainer(Error)
    case showMetarDecoded(Metar)
}

protocol HomePageInteractorProtocol:AnyObject{
    var delegate:HomePageInteractorDelegate? {get set}
    func searchPressed(for icao:[String])
    func metarDecodedPressed()
}

protocol HomePageInteractorDelegate:AnyObject {
    func handleOutPut(_ output: HomePageInteractorOutput)
}

// Presenter

protocol HomePagePresenterProtocol:AnyObject{
    func searchPressed(for icao:[String])
    func metarDecodedPressed()
}




enum HomePagePresenterOutput:Equatable{
    
    case setMetarLoading(Bool)
    case setTafLoading(Bool)
    case showMetar(MetarPresentation)
    case showTaf(TafPresentation)
    case errorContainer(ErrorContainer)
    
}

//Router

enum HomePageRouterOutput{
    case decode(Metar)
}

protocol HomePageRouterProtocol:AnyObject{
    func navigateToRoute(_ route:HomePageRouterOutput)
}

