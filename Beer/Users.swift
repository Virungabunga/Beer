//
//  Users.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-12.
//

import Foundation

class Users: ObservableObject {
    @Published var users  : [User] = []
}
