//
//  MainView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-17.
//

import SwiftUI
import UIKit
struct MainView: View {
   
    @EnvironmentObject var imageLoader : ImageLoader
    @EnvironmentObject var locationManager : LocationManager
    @EnvironmentObject var bars :Bars
    @EnvironmentObject var userHandler : UserHandler
    @State var isSignedIn = false

    @State var selectedTab:Int = 1

//    bars.listenToFirestore()
//    userHandler.listenToFirestore(collection: "Users")
    var body: some View {
        TabView (selection: $selectedTab) {
                LoginView()
                    .tabItem {
                        Label("Login", systemImage: "person.badge.key")
                    }.tag(1)

                FriendView()
                    .tabItem {
                        Label("Friends", systemImage: "person.3")
                    }.tag(2)
            
            ContentView()
                    .tabItem {
                        Label("Map", systemImage: "globe")
                    }.tag(3)
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }.tag(4)
        
            
        
        }.onAppear {
            userHandler.listenToFriendReq()
           
        }
        
    }
}

//struct MainView_Previews: PreviewProvider {
//    @Binding var isSignedIn : Bool
//    static var previews: some View {
//        NavigationView {
//            MainView(isSignedIn: $isSignedIn)
//                .environmentObject(LocationManager())
//                .environmentObject(UserHandler())
//                .environmentObject(Bars())
//        }
//        
//    }
//}
