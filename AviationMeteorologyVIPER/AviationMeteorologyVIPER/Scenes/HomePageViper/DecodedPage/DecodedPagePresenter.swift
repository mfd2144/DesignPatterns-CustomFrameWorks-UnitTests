//
//  decodedPagePresenter.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 23.06.2021.
//

import Foundation
import struct AviatonMeteorologyAPI.Metar

final class DecodePagePresenter:DecodedPagePresenterProtocol{
    weak var delegate: DecodedPageViewProtocol?
    var metar:Metar
    
    init(metar:Metar) {
        self.metar = metar

    }
    
    func load() {
        let metarPresentation = MetarPresentation(metar: metar)
        delegate?.update(metarPresentation)
    }
    
    
}
