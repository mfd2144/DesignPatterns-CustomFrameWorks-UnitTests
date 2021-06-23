//
//  Decoders.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

public enum Decoders{
    public static let plainDateDecoder:JSONDecoder = {
    let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
