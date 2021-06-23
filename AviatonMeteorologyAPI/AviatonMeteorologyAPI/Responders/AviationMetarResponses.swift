//
//  AviationMeteorologyResponder.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

enum RootCodingKey:String, CodingKey{
    case data
}


public struct AviationMetarResponses:Decodable{
    public var results : [Metar]
    
    init(results:[Metar]) {
        self.results = results
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKey.self)
        results = try rootContainer.decode([Metar].self, forKey: .data)
       
        
    }
}








