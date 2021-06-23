//
//  ResultError.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

public enum ResultError: Swift.Error {
    case serializationError(internal:Error)
    case networkingError(internal:Error)
}
