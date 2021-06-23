//
//  SettingsModel.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import Foundation

//use this struct to write and read data from in plist
struct SettingsModel: Codable {
    var elevation: String
    var temperature: String
    var wind: String
    var dewpoint: String
    var barometer: String
    var visibility: String
   
}



//its first check is there any Settings.plist ? If not, first it creates then reads it
struct StartingSettings{
    
   static var startingSettingsModel: SettingsModel = {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Settings.plist")
        do{
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: path!)
            let startingSettings = try decoder.decode(SettingsModel.self, from: data)
            return startingSettings
        }catch{
            let defaultSettings = SettingsModel(elevation: Settings.feet.rawValue, temperature: Settings.celsius.rawValue, wind:  Settings.speed_kts.rawValue, dewpoint: Settings.celsius.rawValue, barometer: Settings.hg.rawValue, visibility: Settings.meters.rawValue)
            
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(defaultSettings)
                try data.write(to: path!)
            }catch{
                print(error.localizedDescription)
            }
            return defaultSettings
        }
    }()
}







enum Settings:String{
    case celsius
    case fahrenheit
    case speed_kts
    case speed_kph
    case feet
    case meters
    case miles
    case metersFloat
    case milesFloat
    case hg
    case mb
}

extension Settings{
    var abbr: String {
        switch self {
        case .hg: return "Hg"
        case .mb: return "Mbar"
        case .feet: return "feet"
        case .meters: return "meters"
        case .miles: return  "miles"
        case .celsius: return "C"
        case .fahrenheit: return "F"
        case .speed_kts: return "Knot"
        case .speed_kph: return  "KPH"
        case .metersFloat:return "meters"
        case .milesFloat:return "miles"
        }
    }
}

