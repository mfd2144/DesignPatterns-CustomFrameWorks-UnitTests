//
//  AviationService.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation
import Alamofire

public protocol AviationTafServiceProtocol{
    func fetchTafReport(icao: [String], completion: @escaping (Results<AviationTafResponses>)->Void)
}

public final class AviationTafService:AviationTafServiceProtocol{
    public init() { }

    public func fetchTafReport(icao: [String], completion: @escaping (Results<AviationTafResponses>) -> Void) {
        
        
        let request = RequestProvider.request(from: icao, for: .taf, to: nil, at: nil)
        
        request.response { (response) in
            
            switch response.result{
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                do {
                    let tafs = try decoder.decode(AviationTafResponses.self, from: data!)
                    completion(.success(tafs))
                } catch let error {
                    completion(.failure(ResultError.networkingError(internal: error)))
                }

            case .failure(let error):
                completion(.failure(ResultError.serializationError(internal: error)))

            }
        }
    }
}






