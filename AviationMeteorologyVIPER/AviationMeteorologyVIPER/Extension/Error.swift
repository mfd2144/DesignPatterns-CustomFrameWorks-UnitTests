//
//  Error.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 19.06.2021.
//

import Foundation


extension Error{
    public static func ==(lhs: Error, rhs: Error)->Bool{
        return lhs.localizedDescription == rhs.localizedDescription
    }
}


final class EmptyFieldError:Error{
        static let description = "Please enter icao code which lenght is 4 charcter"
    }

final class LocationServiceError:Error{
        static let description = "You must allow app to use GPS service"
    }
