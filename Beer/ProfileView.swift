//
//  ProfileView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-16.
//
import SwiftUI
import Foundation

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack{
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(LinearGradient(colors: [.yellow, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing))
                        .edgesIgnoringSafeArea(.top)
                                       .frame(height: 160)
                    Image("Dog").resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .frame(width: 100 ,height: 100)
                        .offset(y:110)
                   
                        
                }
                Text("Handsome doggie")
                    .offset(y:60)
                    .fontWeight(.bold)
                    .bold()
              
               Spacer()
            }
        }
    }
        
}
struct FriendView : View  {
    
    var friends: [User] = [User(id: "sda", name: "dude")]
    
    var body: some View {
        NavigationView {
            ScrollView{
                ForEach(friends,id: \.id) {friend in
                    HStack {
                        Image("Dog")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .clipped()
                            .clipShape(Circle())
                            .frame(width: 80,height: 80)
                        
                        Text(friend.name)
                    }
                    HStack {
                        Button {
                            print("add firend")
                        } label: {
                            Text("add Friend")
                        }
                        
                    }
                    
                    
                    
                }.navigationBarTitle("Friends")
            }
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView()
    }
}
