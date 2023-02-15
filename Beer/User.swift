//
//  User.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-02.
//
import FirebaseAuth
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore

class User: Identifiable, Codable {
    
    enum CodingKeys : CodingKey {
        case id
        case name
        case isAtLocation
        case friendList
    }
    
    
    var id : String
    var name : String
    var isAtLocation : Bool = false
    var friendList  : [String]
    
    

    required  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self,forKey:.id)
        name = try container.decode(String.self,forKey:.name)
        isAtLocation = try container.decode(Bool.self,forKey:.isAtLocation)
        friendList = try container.decode(Array<String>.self, forKey:.friendList)
       
    }
    
    init( id: String, name : String, isAtLocation: Bool, friendList: Array<String> ){
        self.id = id
        self.name = name
        self.isAtLocation = isAtLocation
        self.friendList = friendList
    }
    
    init( id: String, name : String, isAtLocation: Bool){
        self.id = id
        self.name = name
        self.isAtLocation = isAtLocation
        self.friendList = []
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isAtLocation, forKey: .isAtLocation)
        try container.encode(friendList, forKey: .friendList)
    }  
}
    

