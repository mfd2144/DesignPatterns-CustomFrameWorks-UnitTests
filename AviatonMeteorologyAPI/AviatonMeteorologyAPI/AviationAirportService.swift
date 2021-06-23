//
//  AviationAirportService.swift
//  AviatonMeteorologyAPI
//
//  Created by Mehmet fatih DOĞAN on 18.06.2021.
//

import Foundation


import Foundation
import Alamofire

public protocol AviationAirportServiceProtocol{
    func fetchAirportInformation(icao: [String] ,coordinates:Coordinates ,distance:Int ,completion: @escaping (Results<AviationAirportResponses>)->Void)
}

public final class AviationAirportService:AviationAirportServiceProtocol{
    
   public init() { }

    public func fetchAirportInformation(icao: [String] ,coordinates:Coordinates ,distance:Int ,completion: @escaping (Results<AviationAirportResponses>) -> Void) {
        
        
        let request = RequestProvider.request(from: icao, for: .airport, to: coordinates,at: distance)
        
        request.response { (response) in
            
            switch response.result{
            case .success(let data):
                let decoder = Decoders.plainDateDecoder
                do {
                    let airports = try decoder.decode(AviationAirportResponses.self, from: data!)
                    completion(.success(airports))
                } catch let error {
                    completion(.failure(ResultError.networkingError(internal: error)))
                }

            case .failure(let error):
                completion(.failure(ResultError.serializationError(internal: error)))

            }
        }
    }
}
