//
//  AviationTafResponses.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

public struct AviationTafResponses:Decodable{
    public var results : [TAF]
    
    init(results:[TAF]) {
        self.results = results
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKey.self)
        results = try rootContainer.decode([TAF].self, forKey: .data)
       
    }
}
