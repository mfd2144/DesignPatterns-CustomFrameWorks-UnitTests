//
//  HomePagePresenter.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation


final class HomePagePresenter:HomePagePresenterProtocol{
    private var interactor:HomePageInteractorProtocol
    private unowned var view:HomePageViewProtocol
    private var router:HomePageRouterProtocol
    
    init(interactor:HomePageInteractorProtocol,view: HomePageViewProtocol,router:HomePageRouterProtocol) {
        self.interactor = interactor
        self.view = view
        self.router = router
        
        interactor.delegate = self
    }
    
    func searchPressed(for icao: [String]) {
        interactor.searchPressed(for: icao)
    }
    
    func metarDecodedPressed() {
        interactor.metarDecodedPressed()
    }
    
    
}

extension HomePagePresenter:HomePageInteractorDelegate {
    func handleOutPut(_ output: HomePageInteractorOutput) {
        switch output {
        case .showMetar(let metars):
            guard  let metar = metars.first else {return}
            let metarPresentation = MetarPresentation.init(metar: metar)
            view.handleOutput(.showMetar(metarPresentation))
        case .showTaf(let tafs):
            guard  let taf = tafs.first else {return}
            let tafPresentation = TafPresentation.init(taf: taf)
            view.handleOutput(.showTaf(tafPresentation))
       
        case .showMetarDecoded(let metar):
            router.navigateToRoute(.decode(metar))
            
        case .metarErrorContainer(let error):
            view.handleOutput(.errorContainer(.modelError(error)))
        case .tafErrorContainer(let error):
            view.handleOutput(.errorContainer(.modelError(error)))
        case.setMetarLoading(let isLoading):
            view.handleOutput(.setMetarLoading(isLoading))
        case .setTafLoading(let isLoading):
            view.handleOutput(.setTafLoading(isLoading))
        
        }
    }
    
    
}
