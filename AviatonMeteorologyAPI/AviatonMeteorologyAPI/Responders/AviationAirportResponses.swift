//
//  AviationAirportResponses.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

public struct AviationAirportResponses:Decodable{
    public var results : [Airport]
    
    public init(results:[Airport]){
        self.results = results
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKey.self)
        results = try rootContainer.decode([Airport].self, forKey: .data)
       
    }
}
