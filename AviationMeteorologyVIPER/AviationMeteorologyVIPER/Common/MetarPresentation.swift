//
//  MetarPresentation.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import struct AviatonMeteorologyAPI.Metar



public final class MetarPresentation:NSObject{

    let name:String
    let flightCategory:String
    let icao:String
    let metarText:String
    let time:Date
    let latitude :Double
    let longitude:Double
    let barometerHg :Double
    let windSpeed:Int
    let windDirection:Int
    let condition:String?
    let thermometer:Int
    let dewPoint:Int
    let flightRUle:String
    let cloud:String?
    let visibility:String
    let elevation:Int
    
    public init(name:String, flightCategory:String, icao:String, metarText:String, time:Date, latitude :Double, longitude:Double, barometerHg :Double, windSpeed:Int , windDirection:Int , condition:String?, thermometer:Int, dewPoint:Int, cloud:String?, visibility:String ,elevation:Int){
        self.name = name
        self.flightCategory = flightCategory
        self.icao = icao
        self.metarText = metarText
        self.time = time
        self.latitude = latitude
        self.longitude = longitude
        self.barometerHg = barometerHg
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.condition = condition
        self.thermometer = thermometer
        self.dewPoint = dewPoint
        self.flightRUle = flightCategory
        self.cloud = cloud
        self.elevation = elevation
        self.visibility = visibility

        
    }
}

extension MetarPresentation{
    convenience init(metar: Metar){
        self.init(name: metar.station.name, flightCategory: metar.flightCategory, icao: metar.icao, metarText: metar.metarText, time: metar.time, latitude: metar.station.geometry.coordinates.first!, longitude: metar.station.geometry.coordinates.last!, barometerHg: metar.barometer.hg, windSpeed: metar.wind.speedKts, windDirection: metar.wind.degrees, condition: metar.clouds.first?.text , thermometer: metar.temperature.celsius, dewPoint: metar.dewpoint.celsius, cloud: metar.clouds.first?.code, visibility: metar.visibility.meters ,elevation: metar.elevation.feet)
    }
}

extension MetarPresentation{
    public static func == (lhs: MetarPresentation, rhs: MetarPresentation) -> Bool {
        return lhs.metarText == rhs.metarText
    }
    
    
}


