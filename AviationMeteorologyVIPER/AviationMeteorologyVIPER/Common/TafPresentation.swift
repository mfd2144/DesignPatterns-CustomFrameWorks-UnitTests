//
//  TafPresentation.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import struct AviatonMeteorologyAPI.TAF


public class TafPresentation:NSObject{
    
    let icao:String
    let tafText:String
    
    public init(icao:String, tafText:String){
        self.icao = icao
        self.tafText = tafText
    }
}

extension TafPresentation{
    convenience init(taf: TAF){
        
        self.init(icao:taf.icao,tafText:taf.tafText)
    }
}

extension TafPresentation{
    public static func == (lhs: TafPresentation, rhs: TafPresentation) -> Bool {
       return lhs.tafText == rhs.tafText
    }
    
    
}
