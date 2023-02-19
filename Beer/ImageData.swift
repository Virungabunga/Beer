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

struct ImageData: Codable, Identifiable   {
    @DocumentID var id: String?
    var imageUrlString : String = ""
    var description = ""
    var user = Auth.auth().currentUser?.email ?? ""
    var postedOn = Date()
    
    var dictionary : [String : Any] {
        return ["imagUrlString" : imageUrlString, "description" : description, "user" : user, "postedOn" : Timestamp(date: Date())]
    }
    
    
}
