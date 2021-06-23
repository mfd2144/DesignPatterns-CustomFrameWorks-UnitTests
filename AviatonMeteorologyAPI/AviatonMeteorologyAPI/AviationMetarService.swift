//
//  AviationMetarService.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation

import Foundation
import Alamofire

public protocol AviationMetarServiceProtocol:AnyObject{
    func fetchMetarReport(icao:[String], completion: @escaping (Results<AviationMetarResponses>)->Void)
}

public final class AviationMetarService:AviationMetarServiceProtocol{
    public init() { }
    
    public func fetchMetarReport(icao:[String], completion: @escaping (Results<AviationMetarResponses>) -> Void) {
        let request = RequestProvider.request(from: icao, for: .metar, to: nil, at: nil)
        
        request.response { (response) in
            switch response.result{
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                do {
                    let metars = try decoder.decode(AviationMetarResponses.self, from: data!)
                    completion(.success(metars))
                } catch let error {
                    completion(.failure(ResultError.networkingError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(ResultError.serializationError(internal: error)))

            }
        }
    }
}

