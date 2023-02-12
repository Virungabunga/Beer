//
//  Bars.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

import Foundation
import MapKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class Bars : ObservableObject {
    var listOfItems : [MKMapItem] = []
    var locationManager : LocationManager?
    @Published var bars : [Bar] = []
    let db = Firestore.firestore()
    
    
    
    func readFromFb() {
        
        db.collection("Bars").addSnapshotListener { (querySnapshot, error) in
         
            guard  let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.bars = documents.map { d in
                
                return Bar(name:d["name"] as! String,
                           latitude: d["latitude"] as! Double,
                           longitude: d["longitude"] as! Double,
                           phone: d["phone"] as! String,
                            liveReview: d["liveReview"] as! String)
            }
        }
    }
    
    
    func writeToFB(bar : Bar) {
        do {
            try db.collection("Bars").document().setData(from:bar)
        } catch {
            print(error)
        }
    }
    
    
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
                        print(item.description)
                        
                        
                        
                        self.bars.append(Bar(name: item.name!,
                                             latitude: item.placemark.coordinate.latitude,
                                             longitude: item.placemark.coordinate.longitude,
                                             phone: item.phoneNumber!,liveReview: ""))
                        for bar in self.bars {
                            self.writeToFB(bar: bar)
                            
                        }
                        
                    }
                }
                
                
            }
            
        }
    }
}
