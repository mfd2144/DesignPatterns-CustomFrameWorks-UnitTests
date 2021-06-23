//
//  AirportModel.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation



public struct Airport:Decodable {
  
    public let name:String
    public let status:String
    public let type:String
    public let iata:String?
    public let icao:String
    public let position:Position
    public let city:String?
    public let country:Country
    public let timezone:Timezone
  
}

public struct Country:Decodable{
    public let code:String
    public let name:String
}

public struct Timezone:Decodable{
    public let tzid:String
    public let dst:Int
    public let gmt:String
}

public struct Position:Decodable{
    public enum CodingKeys:String, CodingKey {
        case coordinates = "base"
        case meters, miles, bearing
    }
    
    public let coordinates:Coordinates
    public let meters:Double
    public let miles:Double
    public let bearing:Bearing
}

public struct Coordinates:Decodable{
    public let latitude:Double
    public let longitude:Double
    
    public init(_ lat:Double,_ lon:Double){
        self.latitude = lat
        self.longitude = lon
    }
    
}

public struct Bearing:Decodable{
    
    public let from:Int
    public let to:Int
}



