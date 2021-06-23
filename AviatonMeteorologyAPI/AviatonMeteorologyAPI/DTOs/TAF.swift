//
//  TAF.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

public struct TAF:Decodable{
   
    public enum CodingKeys:String,CodingKey{
        case icao,station,timestamp
        case tafText = "raw_text"
      
    }
    
    public let icao:String
    public let tafText:String
    public let station:Station
    public let timestamp:Timestamp
}

public struct Timestamp:Decodable{
    public let from:Date
    public let to:Date

}
