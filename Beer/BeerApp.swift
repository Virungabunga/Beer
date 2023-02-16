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
    @StateObject var locationManager = LocationManager()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
          ContentView()
                .environmentObject(locationManager)
                .environmentObject(userHandler)
                .environmentObject(bars)
        }
    }
}
