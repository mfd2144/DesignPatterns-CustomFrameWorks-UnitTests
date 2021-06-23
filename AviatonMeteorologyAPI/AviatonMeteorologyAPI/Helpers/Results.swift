//
//  Results.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

public enum Results<Value>{
    case success(Value)
    case failure(Error)
}


