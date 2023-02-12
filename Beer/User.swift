//
//  User.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-02.
//
import FirebaseAuth
import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let uscerName : String
    var  isAtLocation : Bool
    var  friends : Array<String>
    

}
