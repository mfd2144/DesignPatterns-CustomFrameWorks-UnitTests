//
//  AirportPresentation.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import Foundation
import AviatonMeteorologyAPI

final class AirportPresentation{
    let name:String
    let status:String
    let type:String
    let iata:String?
    let icao:String
    let city:String?
    let countryName:String
    let countryCode:String
    let tzid:String
    let dst:Int
    let gmt:String
    let meters:Double
    let miles:Double
    let latitude:Double
    let longitude:Double
    let from:Int
    let to:Int

    
    init(name:String, status:String, type:String, iata:String?, icao:String, city:String?, countryName:String,countryCode:String, tzid:String, dst:Int, gmt:String, meters:Double,miles:Double,latitude:Double,longitude:Double,from:Int, to:Int) {
        
        self.name = name
        self.status = status
        self.type = type
        self.iata = iata
        self.icao = icao
        self.city = city
        self.countryName = countryName
        self.countryCode = countryCode
        self.tzid = tzid
        self.gmt = gmt
        self.dst = dst
        self.miles = miles
        self.meters = meters
        self.latitude = latitude
        self.longitude = longitude
        self.from = from
        self.to = to
    }
    convenience init(airprt:Airport){
        self.init(name: airprt.name, status: airprt.status, type: airprt.type, iata: airprt.iata, icao: airprt.icao, city: airprt.city, countryName: airprt.country.name, countryCode:airprt.country.code, tzid: airprt.timezone.tzid, dst: airprt.timezone.dst, gmt: airprt.timezone.gmt, meters: airprt.position.meters, miles: airprt.position.miles, latitude: airprt.position.coordinates.latitude, longitude: airprt.position.coordinates.longitude, from: airprt.position.bearing.from, to: airprt.position.bearing.to)
    }
    
}
