//
//  LocationManager.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

import Foundation
import CoreLocation

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    var location : CLLocationCoordinate2D?
    let manager = CLLocationManager()
   
    override init() {
        super.init()
        manager.delegate = self
      
    }

    func startLocationUpdates  ()  {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        print(" plats uppdaterat \(location)")
    }
}
