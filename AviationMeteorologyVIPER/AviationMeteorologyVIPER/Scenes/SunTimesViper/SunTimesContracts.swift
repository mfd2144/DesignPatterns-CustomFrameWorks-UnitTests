//
//  SunTimesContracts.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import Foundation


import Foundation
import AviatonMeteorologyAPI


//View

protocol SunTimesPageViewProtocol:AnyObject{
    func handleOutput(_ output: SunTimesPagePresenterOutput)
}

//Intrector

enum SunTimesPageInteractorOutput{
    case setSunTimes(Bool)
    case showSunTimes([SunTimes])
    case sunTimesErrorContainer(Error)
}

protocol SunTimesPageInteractorProtocol:AnyObject{
    var delegate:SunTimesPageInteractorDelegate? {get set}
    func searchPressed(for icao:String)
}

protocol SunTimesPageInteractorDelegate:AnyObject {
    func handleOutPut(_ output: SunTimesPageInteractorOutput)
}

// Presenter

protocol SunTimesPagePresenterProtocol:AnyObject{
    func searchPressed(for icao:String)
}


enum SunTimesPagePresenterOutput:Equatable{
    case setSunTimes(Bool)
    case showSunTimes(SunTimesPresentation)
    case sunTimesErrorContainer(ErrorContainer)
    
}

//Router
//Empty
