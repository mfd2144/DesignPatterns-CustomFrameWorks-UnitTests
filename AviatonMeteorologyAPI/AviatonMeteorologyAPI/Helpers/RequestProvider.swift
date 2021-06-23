//
//  UrlProvider.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import Alamofire


enum ReportType:String{
    case metar
    case taf
    case airport
    case suntimes
}

enum RequestProvider{
    static func request(from icao:[String],for reportType:ReportType ,to coordinates:Coordinates? ,at distance:Int?)->DataRequest{
        var url:String = ""
        let baseUrlString = "https://api.checkwx.com/"
        let header: HTTPHeader = HTTPHeader(name: "x-api-key", value: "f4b9b9bc01174a21b92494cab4")
        let headears = HTTPHeaders([header])
        
        if reportType == .metar || reportType == .taf {
             url = "\(baseUrlString)\(reportType.rawValue)/\(icao.map({$0}).joined(separator: ","))/decoded"
        }else {
            //suntimes or airport url
            if coordinates == nil && distance == nil{
                //Suntimes
                url = "\(baseUrlString)station/\(icao.map({$0}).first ?? "")/\(reportType.rawValue)"
               
            }else if let coordinates = coordinates ,let distance = distance{
            //https://api.checkwx.com/station/lat/37.32689395/lon/-122.02685541/radius/10
               // airport
               
                    url = "\(baseUrlString)station/lat/\(coordinates.latitude)/lon/\(coordinates.latitude)/radius/\(distance)"

            }
        }
        return AF.request(url,method: .get,headers: headears)
    }
}
