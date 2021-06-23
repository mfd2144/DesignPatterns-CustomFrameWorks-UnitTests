//
//  SunTimesInteractor.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import Foundation
import AviatonMeteorologyAPI

final class SunTimesPageInteractor:SunTimesPageInteractorProtocol{
    weak var delegate: SunTimesPageInteractorDelegate?
    private var service: AviationSunTimesServiceProtocol!
    
    init(service:AviationSunTimesServiceProtocol){
        self.service = service
    }
    
    func searchPressed(for icao: String) {
        delegate?.handleOutPut(.setSunTimes(true))
        service.fetchSunTimes(icao: [icao]) {[weak self] result in
            guard let self = self else {return}
            self.delegate?.handleOutPut(.setSunTimes(false))
            switch result{
            case .failure(let error):
                self.delegate?.handleOutPut(.sunTimesErrorContainer(error))
            case .success(let sunsets):
                self.delegate?.handleOutPut(.showSunTimes(sunsets.result))
            }
        }
    }
}
