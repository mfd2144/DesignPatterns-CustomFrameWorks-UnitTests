//
//  Metar.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation


public struct Metar:Decodable{
    public enum CodingKeys: String,CodingKey{
        case icao,dewpoint,barometer,station,elevation,temperature,visibility,wind,clouds
        case time = "observed"
        case flightCategory="flight_category"
        case metarText = "raw_text"
   
    }
    
    public  let icao:String
    public let metarText:String
    public let time:Date
    public let barometer:Barometer
    public let temperature:HeatMeasure
    public let dewpoint:HeatMeasure
    public let station:Station
    public let flightCategory:String
    public let elevation:Elevation
    public let visibility:Visibility
    public let wind:Wind
    public let clouds:[Cloud]

}

public struct Barometer:Decodable{
    public let hg:Double
    public let mb:Double
}

public struct HeatMeasure:Decodable {
    public let celsius:Int
    public let fahrenheit:Int
}

public struct Elevation:Decodable {
    public let feet:Int
    public let meters:Int
}

public struct Station:Decodable {
    public let location:String
    public let geometry:Geometry
    public let name:String
}

public struct Geometry:Decodable {
    public let coordinates:[Double]
}


public struct Visibility:Decodable{
    
    public enum CodingKeys:String,CodingKey{
        case meters,miles
        case metersFloat = "meters_float"
        case milesFloat = "miles_float"
    }
    
    public let meters:String
    public let metersFloat:Double
    public let miles:String
    public let milesFloat:Double
}

public struct Wind:Decodable{
    
    public enum CodingKeys:String,CodingKey{
        case degrees
        case speedKph = "speed_kph"
        case speedKts = "speed_kts"
    }
    
    public let degrees:Int
    public let speedKph:Int
    public let speedKts:Int

}

public struct Cloud:Decodable{
    public let code:String
    public let text:String
}




