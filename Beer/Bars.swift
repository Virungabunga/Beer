//
//  Bars.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

import Foundation
import MapKit
class Bars : ObservableObject{
    var listOfItems : [MKMapItem] = []
    var locationManager : LocationManager?
   @Published var bars : [Bar] = []
    
    

    func fetchData(locationManager:LocationManager) {
      
        if let location = locationManager.location{
            var filter = MKPointOfInterestFilter(including:[.nightlife])
            let request =  MKLocalPointsOfInterestRequest(center: location, radius: 200)
            request.pointOfInterestFilter = filter
            let searchObject = MKLocalSearch(request: request)
            
            searchObject.start() { response, error in
           
                if let mapItems = response?.mapItems {
                    self.listOfItems = mapItems
                    
                    for item in mapItems{
                    print(item)
                        self.bars.append(Bar(name: item.description, placeMark: item.placemark))
                    }
                    
                   
                    
                }
                
                
            }
            
        }
    }
}
