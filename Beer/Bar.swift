//
//  Bar.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

import Foundation
import MapKit
class Bar : Identifiable  {
    
    var id = UUID()
    var name : String = ""
    var placeMark : MKPlacemark
    
    init(id: UUID = UUID(), name: String, placeMark : MKPlacemark) {
        self.id = id
        self.name = name
        self.placeMark = placeMark
        
    }

    
}
