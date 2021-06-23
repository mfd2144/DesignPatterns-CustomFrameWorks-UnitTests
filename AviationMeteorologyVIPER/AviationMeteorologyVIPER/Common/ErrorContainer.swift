//
//  ErrorContainer.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 20.06.2021.
//

import Foundation

enum ErrorContainer:Error{
    case modelError(Error)
}
extension ErrorContainer:Equatable{
    static func == (lhs: ErrorContainer, rhs: ErrorContainer) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
