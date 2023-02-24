//
//  ImageData.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-19.
//

import Foundation
import Swift
import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase
import SwiftUI

struct ImageData : Identifiable   {
    @DocumentID var id : String?
    var imageUrlString : String = ""
    var barId : String = ""
//    var description = ""
//    var postedOn = Date()
    var image  : UIImage?
 
    
    var dictionary : [String : Any] {
        return ["imagUrlString" : imageUrlString, "barId" : barId]
    }
//
    
//    , "description" : description, "postedOn" : Timestamp(date: Date())
}
