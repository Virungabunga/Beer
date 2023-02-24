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
    @State var isSignedIn: Bool = false
    @StateObject var bars = Bars()
    @StateObject var userHandler = UserHandler()
    @StateObject var locationManager = LocationManager()
    @StateObject var imageLoader = ImageLoader()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView(isSignedIn:isSignedIn)
                .environmentObject(locationManager)
                .environmentObject(userHandler)
                .environmentObject(bars)
                .environmentObject(imageLoader)
               
        }
    }
}
