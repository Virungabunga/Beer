//
//  Bars.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//
import CryptoKit
import Foundation
import MapKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class Bars : ObservableObject {
    @MainActor 
    var listOfItems : [MKMapItem] = []
    var locationManager : LocationManager?
    @Published var bars : [Bar] = []
    let db = Firestore.firestore()
    
    
    
    
    func listenToFirestore() {
        db.collection("Bars").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                //                        items.removeAll()
                for document in snapshot.documents {
                    
                    let result = Result {
                        try document.data(as: Bar.self)
                    }
                    switch result  {
                    case .success(let item)  :
                       
                        self.bars.append(item)
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
    }
    
    func hashStrig(stringToHash:String)  -> String{
        
        let inputData = Data(stringToHash.utf8)
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
       
        print(hashString)
        return hashString
    }
    
  
    
    
    func writeToFB(bar : Bar) {
        do {
            try
            //
            db.collection("Bars").document(bar.id).setData(from:bar)
        } catch {
            print(error)
        }
    }
    
    
    func fetchDataFromMaps(locationManager:LocationManager) {
        
        if let location = locationManager.location{
            let filter = MKPointOfInterestFilter(including:[.nightlife])
            let request =  MKLocalPointsOfInterestRequest(center: location, radius: 200)
            request.pointOfInterestFilter = filter
            let searchObject = MKLocalSearch(request: request)
            
            searchObject.start() { response, error in
                
                if let mapItems = response?.mapItems {
                    self.listOfItems = mapItems
                
                    for item in mapItems{
                        if let name = item.name {
                            print(item.description)
                            
                            let id = self.hashStrig(stringToHash: name)
                            

                            self.bars.append(Bar(id:id,name: name,
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
}
