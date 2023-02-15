//
//  BeerApp.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

import SwiftUI
import Firebase 
@main
struct BeerApp: App {

    @StateObject var bars = Bars()
    @StateObject var userHandler = UserHandler()
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
          ContentView()
                .environmentObject(userHandler)
                .environmentObject(bars)
        }
    }
}
