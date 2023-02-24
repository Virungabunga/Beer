//
//  ProfileView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-16.
//
import SwiftUI
import Foundation
import UIKit
struct ProfileView: View {
    @State var showSheet = false
    @EnvironmentObject var userHandler : UserHandler
    @EnvironmentObject var imageLoader : ImageLoader
    @State var changeColor : Bool = false
    var body: some View {
        NavigationView {
            VStack{ 
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(LinearGradient(colors: [.yellow, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing))
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 160)
                    
                    Image(uiImage: imageLoader.profilImage )
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .frame(width: 100 ,height: 100)
                        .offset(y:110)
                    
                    Text("change photo")
                        .offset(y:210)
                        .onTapGesture {
                            showSheet = true
                        }
                    
                        .padding(.horizontal, 20)
                        .sheet(isPresented: $showSheet) {
                            // Pick an image from the photo library:
                            ImagePicker(sourceType: .photoLibrary)
                            
                           
                        }
                    
                }
                
                Text(userHandler.currentUser.name)
                    .offset(y:60)
                    .fontWeight(.bold)
                    .bold()
                HStack{
                    Text("Friend request")	.offset(y:70)
                        .font(.headline)
                    
                    Toggle ("darkmode",isOn:$changeColor)
                    

                }
                HStack{
                    
                    Button {
                        print(userHandler.friendrequestList)
                        userHandler.sendFriendReq()
                    } label: {
                        Text("send req")
                    }
                    if let requestList = userHandler.friendrequestList {
                        
                        List {
                            
                            ForEach(requestList, id: \.id){ user in
                                Text(user.name)
                                Button {
                                    userHandler.currentUser.friendList?.append(user)
                              
                                } label: {
                                    Text("accept")
                                }
                                
                            }
                        }
                    }
                    
                    
                    
                }.offset(y:60)
                
                
                Spacer()
                
            }.preferredColorScheme(changeColor ? .dark : .light)
            .onAppear {
                imageLoader.retrivePhotos   ()

            }
        }
    }
    
}

// läg i ny 
struct FriendView : View  {
    
    @EnvironmentObject var userHandler :UserHandler
    
    var body: some View {
        
        ScrollView{
            ForEach(userHandler.friendList,id: \.id) {friend in
                HStack {
                    Image("Dog")
                        .resizable()
                        .aspectRatio( contentMode: .fill)
                        .clipped()
                        .clipShape(Circle())
                        .frame(width: 80,height: 80)
                    
                    Text(friend.name)
                }
                
                
                
            }.navigationBarTitle("Friends")
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserHandler())
    }
}
