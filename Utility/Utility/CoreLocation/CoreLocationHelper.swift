//
//  File.swift
//  Utility
//
//  Created by Mehmet fatih DOĞAN on 21.06.2021.
//

import Foundation
import CoreLocation

public protocol CoreLocationUpdateProtocol{
    func handleOutputs(_ output:LocationManagerOutputs)
}


public enum LocationManagerOutputs{
    case didFailWithError(Error)
    case returnLocation(lat:Double,lon:Double)
}

public final class CoreLocationHelper:NSObject{
    
    
    public var delegate:CoreLocationUpdateProtocol?
    private var manager:CLLocationManager?
    private var responder:((LocationManagerOutputs)->())?
    
    public override init() {
        super.init()
        self.manager = CLLocationManager()
        manager?.delegate = self
        manager?.requestWhenInUseAuthorization()
      
        
    }
    
    public func requestActualPoint(){
        manager?.requestLocation()
    }
}


extension CoreLocationHelper:CLLocationManagerDelegate{
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        responder?(.didFailWithError(error))
        manager.startUpdatingLocation()
        delegate?.handleOutputs(.didFailWithError(error))
    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            manager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            responder?(.returnLocation(lat: lat, lon: lon))
            delegate?.handleOutputs(.returnLocation(lat: lat, lon: lon))
            manager.stopUpdatingLocation()
        }
    }
}


extension CoreLocationHelper:CoreLocationUpdateProtocol{
    
    
    public func handleOutputs(_ outputs: LocationManagerOutputs) {
        
    }
    
    
}
