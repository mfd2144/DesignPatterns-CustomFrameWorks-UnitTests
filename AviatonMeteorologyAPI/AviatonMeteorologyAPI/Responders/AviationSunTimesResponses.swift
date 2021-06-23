//
//  AviationSunTimesResponses.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

public struct AviationSunTimesResponses:Decodable{
    public var result : [SunTimes]
    
    init(result:[SunTimes]) {
        self.result = result
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKey.self)
        result = try rootContainer.decode([SunTimes].self, forKey: .data)
       
    }
}
