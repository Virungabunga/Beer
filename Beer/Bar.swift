//
//  Bar.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

//MKPlacemark MKPlacemark conforms to NSSecureCoding. You can just use NSKeyedArchiver and NSKeyedUnarchiver to encode/decode it.
import Foundation
import MapKit
class Bar : Identifiable, Codable  {
    
    enum CodingKeys : CodingKey {
        case id
        case name
        case latitude
        case longitude
//        case placemark
        case phone
        case liveReview
    }
 //Skapa kordinat variabler för att encode och decode för placeMark är ej Codable
    var id = UUID()
    var name : String = ""
    var latitude : Double = 0.0
    var longitude : Double = 0.0
//    var placeMark : MKPlacemark
    var phone : String = ""
    var liveReview : String = ""

  
    
    init(id: UUID = UUID(), name: String, latitude: Double, longitude: Double, phone: String, liveReview : String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
//        self.placeMark = placeMark
        self.phone = phone
        self.liveReview = liveReview
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self,forKey:.id)
        name = try container.decode(String.self,forKey:.name )
        latitude = try container.decode(Double.self,forKey:.latitude )
        longitude = try container.decode(Double.self,forKey:.longitude )
//        placeMark = try container.decode(MKPlacemark.self,forKey:.placemark )
        phone = try container.decode(String.self, forKey: .phone)
        liveReview = try container.decode(String.self, forKey: .liveReview)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(latitude, forKey: .latitude)
        try  container.encode(longitude, forKey: .longitude)
        try container.encode(phone, forKey: .phone)
        try container.encode(liveReview, forKey: .liveReview)

    }
    

    
}
