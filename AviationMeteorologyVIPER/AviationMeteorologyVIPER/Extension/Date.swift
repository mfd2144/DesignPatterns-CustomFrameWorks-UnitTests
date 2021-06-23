//
//  Date.swift
//  AviationMeteorologyVIPER
//
//  Created by Mehmet fatih DOĞAN on 23.06.2021.
//

import Foundation

extension Date{
    public func convertToString()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy hh:mm "
        return formatter.string(from: self)
    }
}
