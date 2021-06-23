//
//  SunTimes.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation



public struct SunTimes:Decodable{
    public enum CodingKeys:String,CodingKey{
        case icao, name, timezone
        case sunriseSunset = "sunrise_sunset"
    }
    
    public let icao:String
    public let name:String
    public let sunriseSunset:SunriseSunset
    public let timezone:Timezone
}


public struct SunriseSunset:Decodable{
    public let local:TimeData
    public let utc:TimeData
}

public struct TimeData:Decodable{
    public let dawn:String
    public let dusk:String
    public let noon:String
    public let sunrise:String
    public let sunset:String
}



