//
//  Review.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-23.
//

import Foundation


struct Review : Codable, Identifiable {
    var id : UUID
    var text: String
    var imageId : String
}
