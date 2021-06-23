//
//  AviationSunsetService.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//


import Foundation
import Alamofire

public protocol AviationSunTimesServiceProtocol{
    func fetchSunTimes(icao:[String], completion: @escaping (Results<AviationSunTimesResponses>)->Void)
}

public final class AviationSuntimesService:AviationSunTimesServiceProtocol{
    public init() { }
    
    public func fetchSunTimes(icao:[String], completion: @escaping (Results<AviationSunTimesResponses>) -> Void) {
        let request = RequestProvider.request(from: icao, for: .suntimes, to: nil, at: nil)
        
        request.response { (response) in
            
            switch response.result{
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                do {
                    let sunTimes = try decoder.decode(AviationSunTimesResponses.self, from: data!)
                    completion(.success(sunTimes))
                } catch let error {
                    completion(.failure(ResultError.networkingError(internal: error)))
                }

            case .failure(let error):
                completion(.failure(ResultError.serializationError(internal: error)))

            }
        }
    }
}


