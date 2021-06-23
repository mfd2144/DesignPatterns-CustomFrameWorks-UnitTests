//
//  SunTimesPresentation.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import Foundation
import AviatonMeteorologyAPI

final class SunTimesPresentation{
  
    
    let icao: String
    let name: String
    let local: Times
    let utc: Times
    let tzid:String
    let dst:Int
    let gmt:String

    
    
    struct Times:Equatable {
    public let dawn:String
    public let dusk:String
    public let noon:String
    public let sunrise:String
    public let sunset:String
    }
    
    init(icao:String, name:String, local:Times, utc:Times,tzid:String,dst:Int,gmt:String){
        self.icao = icao
        self.name = name
        self.local = local
        self.utc = utc
        self.tzid = tzid
        self.dst = dst
        self.gmt = gmt
        
    }
    
    
    convenience init(sunTimes:SunTimes){
        let local = Times(dawn: sunTimes.sunriseSunset.local.dawn
                          , dusk: sunTimes.sunriseSunset.local.dusk
                          , noon: sunTimes.sunriseSunset.local.noon
                          , sunrise: sunTimes.sunriseSunset.local.sunrise
                          , sunset: sunTimes.sunriseSunset.local.sunset)
        
        let utc = Times(dawn: sunTimes.sunriseSunset.utc.dawn
                        , dusk: sunTimes.sunriseSunset.utc.dusk
                        , noon: sunTimes.sunriseSunset.utc.noon
                        , sunrise: sunTimes.sunriseSunset.utc.sunrise
                        , sunset: sunTimes.sunriseSunset.utc.sunset)
        
        self.init(icao: sunTimes.icao, name: sunTimes.name, local: local, utc: utc, tzid: sunTimes.timezone.tzid , dst:sunTimes.timezone.dst, gmt:sunTimes.timezone.gmt)
    }
    
 
}

extension SunTimesPresentation:Equatable{
    static func == (lhs: SunTimesPresentation, rhs: SunTimesPresentation) -> Bool {
        lhs.icao == rhs.icao && lhs.local.sunrise == rhs.local.sunrise && lhs.local.noon == rhs.local.noon
    }
    
    
}
