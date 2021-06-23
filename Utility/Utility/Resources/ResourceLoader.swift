//
//  ResourceLoader.swift
//  Utility
//
//  Created by Mehmet fatih DOĞAN on 19.06.2021.
//

import Foundation
import AviatonMeteorologyAPI


extension Bundle{
    class Dummy{ }
    static let test = Bundle(for: Dummy.self)
}


public class ResourceLoader {

    public enum MetarResources:String{
    case metarData1
    case metarData2
    case metarData3
    
}
    public struct DidResourceLoadError:Error{  }
    
   public static func loadSingleMetar(resource:MetarResources)throws->Metar{
        let bundle = Bundle.test
        guard let url = bundle.url(forResource: resource.rawValue, withExtension: "json") else {throw  DidResourceLoadError()}
        let data = try Data.init(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let metar = try decoder.decode(Metar.self, from: data)
  
        return metar
    }
    
}

extension ResourceLoader{
    public enum TafResources:String{
    case tafData1
    case tafData2
    case tafData3
    
}
    
   public static func loadSingleTaf(resource:TafResources)throws->TAF{
        let bundle = Bundle.test
        guard let url = bundle.url(forResource: resource.rawValue, withExtension: "json") else {throw  DidResourceLoadError()}
        let data = try Data.init(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let taf = try decoder.decode(TAF.self, from: data)
        return taf
    }
}


extension ResourceLoader{

        public enum SunTimesResources:String{
        case sunTimes1
        case sunTimes2
        case sunTimes3
        }
    
    
    public static func loadSunTimes(resource:SunTimesResources)throws->SunTimes{
         let bundle = Bundle.test
         guard let url = bundle.url(forResource: resource.rawValue, withExtension: "json") else {throw  DidResourceLoadError()}
         let data = try Data.init(contentsOf: url)
         let decoder = Decoders.plainDateDecoder
         let sunTimes = try decoder.decode(SunTimes.self, from: data)
         return sunTimes
     }
}



extension ResourceLoader{

        public enum AirportResources:String{
        case airport1
        case airport2
        case airport3
        }
    
    
    public static func loadAirports(resource:AirportResources)throws->Airport{
         let bundle = Bundle.test
         guard let url = bundle.url(forResource: resource.rawValue, withExtension: "json") else {throw  DidResourceLoadError()}
         let data = try Data.init(contentsOf: url)
         let decoder = Decoders.plainDateDecoder
         let airport = try decoder.decode(Airport.self, from: data)
         return airport
     }
}



