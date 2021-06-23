//
//  SunTimesPresenter.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import Foundation

final class SunTimesPagePresenter:SunTimesPagePresenterProtocol{
    var interactor:SunTimesPageInteractorProtocol!
    unowned var view:SunTimesPageViewProtocol!
    
    init(interactor:SunTimesPageInteractorProtocol,view:SunTimesPageViewProtocol) {
        self.interactor = interactor
        self.view = view
        
        interactor.delegate = self
        
    }
    
    func searchPressed(for icao: String) {
        controlIcaoCode(for: icao)
    }
}

extension SunTimesPagePresenter:SunTimesPageInteractorDelegate{
    func handleOutPut(_ output: SunTimesPageInteractorOutput) {
        switch output {
        case .setSunTimes(let isLoading):
            view.handleOutput(.setSunTimes(isLoading))
        case .showSunTimes(let sunTimes):
            guard let sunTime = sunTimes.first else {return }
            let sunTimesPresentation = SunTimesPresentation.init(sunTimes: sunTime)
            view.handleOutput(.showSunTimes(sunTimesPresentation))
        case .sunTimesErrorContainer(let error):
            view.handleOutput(.sunTimesErrorContainer(.modelError(error)))
        }
    }
    
    
    func controlIcaoCode(for icao:String){
        if icao.count == 4 {
            interactor.searchPressed(for: icao)
        }else{
            view.handleOutput(.sunTimesErrorContainer(.modelError(EmptyFieldError())))
        }
    }
    
    
}

