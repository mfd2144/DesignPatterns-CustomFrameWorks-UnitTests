//
//  RoutePageViewControl.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 22.06.2021.
//

import UIKit
import AviatonMeteorologyAPI

final class RoutePageViewController:UIViewController{
    var tafMetars = [TafMetarPresentation]()
    var metarService: AviationMetarServiceProtocol!
    var tafService: AviationTafServiceProtocol!
    var metars:[Metar]?
    @IBOutlet weak var routeView:RouteViewProtocol!{
        didSet{
            routeView.delegate = self
        }
    }
}

extension RoutePageViewController:RouteViewDelegate{
    func searchRoute(for codes: [String]) {
        routeView.setLoading(true)
        metarService.fetchMetarReport(icao: codes) { [weak self] results in
            guard let self = self else {return}
            switch results{
            case .failure(let error):
            self.routeView.routeError(error)
            case .success(let metarData):
                self.metars = metarData.results
                let metarPresentations = metarData.results.sorted(by: {$0.icao<$1.icao}).map(MetarPresentation.init)
                self.setTafMetarArray(tafs: nil, metars: metarPresentations)
            }
        }
        
        tafService.fetchTafReport(icao: codes) { [weak self] results in
            guard let self = self else {return}
            switch results{
            case .failure(let error):
            self.routeView.routeError(error)
            case .success(let tafData):
                let tafPresentations = tafData.results.sorted(by: {$0.icao<$1.icao}).map(TafPresentation.init)
                self.setTafMetarArray(tafs: tafPresentations, metars: nil)
            }
        }
        
    }
    
    func selectAnAirport(for icao: String) {
        guard let metars = metars else {return}
        metars.forEach { metar in
            if metar.icao == icao{
                let decodedPage = DecodedPageBuilder.make(with: metar)
                show(decodedPage, sender: nil)
            }
        }
    }

    
    
    
    private func setTafMetarArray(tafs:[TafPresentation]?,metars:[MetarPresentation]?){
        routeView.setLoading(false)
        if tafMetars.count == 0 {
            //First input cames
            if let tafs = tafs{
                //Taf is first caller
                tafMetars = tafs.map({TafMetarPresentation(taf: $0, metar: nil)})
            }else if let metars = metars{
                //Metaris first caller
                tafMetars = metars.map({TafMetarPresentation.init(taf: nil, metar:  $0)})
            }
        }else {
            // already have input
            if  tafMetars.first?.taf == nil {
                //new input add to taf
                guard let tafs = tafs else {return}
                
                for taf in tafs{
                
                    for (index,singleElement) in tafMetars.enumerated(){
                 
                        if singleElement.metar?.icao == taf.icao {
                            tafMetars[index].taf = taf
                            break
                        }else if index == tafMetars.count-1{
                            let newTafMetar = TafMetarPresentation(taf: taf, metar: nil)
                            tafMetars.append(newTafMetar)
                        }
                    }
                   
                }
            }else {
                //new input add to metar
                    //new input add to taf
                    guard let metars = metars else {return}
                    for metar in metars{
                    
                        for (index,singleElement) in tafMetars.enumerated(){
                          
                            if singleElement.taf?.icao == metar.icao{
                                tafMetars[index].metar = metar
                
                                break
                            } else if index == tafMetars.count-1{
                                let newTafMetar = TafMetarPresentation(taf: nil, metar: metar)
                                tafMetars.append(newTafMetar)
                            }
                        }
                      
                    }
            }
       
        }
        routeView.returnReports(tafMetars: tafMetars)
    }
    
}


