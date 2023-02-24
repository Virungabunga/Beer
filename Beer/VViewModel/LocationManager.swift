//
//  LocationManager.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager : NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3323341, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
    
    var location : CLLocationCoordinate2D?
    let manager = CLLocationManager()
    var distanceToBar : Double = 0.0
    
    
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
