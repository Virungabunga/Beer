//
//  User.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-02.

import FirebaseAuth
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore

struct User: Identifiable, Codable{
    
    var id : String
    var name : String
    var isAtLocation : Bool
    var friendReq : Bool
    var friendReqList: [User]?
    
    

    
    init( id: String, name : String, isAtLocation: Bool, friendList: [User], friendReq: Bool, friendReqList: [User] ){
        self.id = id
        self.name = name
        self.isAtLocation = isAtLocation
        self.friendReq = friendReq
        self.friendReqList = friendList
    }
 
    init( id: String, name : String){
        self.id = id
        self.name = name
        self.isAtLocation = false
        self.friendReq = false
    }

    
}
    

