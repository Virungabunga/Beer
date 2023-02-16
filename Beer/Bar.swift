//
//  Bar.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

//MKPlacemark MKPlacemark conforms to NSSecureCoding. You can just use NSKeyedArchiver and NSKeyedUnarchiver to encode/decode it.
import Foundation
import MapKit
struct Bar : Identifiable, Codable  {
    

 //Skapa kordinat variabler för att encode och decode för placeMark är ej Codable
    var id : String = ""
    var name : String = ""
    var latitude : Double = 0.0
    var longitude : Double = 0.0
//    var placeMark : MKPlacemark
    var phone : String = ""
    var liveReview : String = ""

  
    
    init(id: String, name: String, latitude: Double, longitude: Double, phone: String, liveReview : String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
//        self.placeMark = placeMark
        self.phone = phone
        self.liveReview = liveReview
        
    }
    



    
}
