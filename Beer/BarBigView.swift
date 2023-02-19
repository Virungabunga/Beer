//
//  BarBigView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-17.
//

import SwiftUI

struct BarBigView: View {
    var friends: [User] = [User(id: "sda", name: "dude"),User(id: "sda", name: "dude"),User(id: "sda", name: "dude")]
 
    @EnvironmentObject var bars :Bars
    @EnvironmentObject var userHandler :UserHandler
    
    var body: some View {
            VStack(alignment: .leading){
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(LinearGradient(colors: [.yellow, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing))
                        .edgesIgnoringSafeArea(.top)
                        .frame(height: 160)
          
                }
                
                Text(bars.barSelected.name)
                    .offset(y:20)
                    .font(.title)
                    .bold()
                    
                ScrollView(.horizontal){
                    HStack{
                        Image(systemName: "person.2.fill")
                            .foregroundColor(.green)
                            .offset(y:20)
                        Spacer()
                        ForEach(friends,id: \.id) {friend in
                            
                            Image("Dog")
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .clipped()
                                .clipShape(Circle())
                                .frame(width: 50,height: 50)
                            
                            Text(friend.name)
                        }
                        
                        
                    }
                }
                HStack{
                    Image(systemName: "phone")
                       
                    
                    Text(bars.barSelected.phone)
                    Spacer()
                    Image(systemName: "network")
                    Text("add webbsite")
                }.offset(y:30)
                
                NavigationLink {
                    ExtractedView()
                } label: {
                    Text("postlive reiew and pic")
                }.offset(y:50)

                
                ScrollView{
                    Text(bars.barSelected.liveReview)
                    
                }.offset(y:50)
                Spacer()
            }
        }
    }


struct BarBigView_Previews: PreviewProvider {
    static var previews: some View {
        BarBigView()
            .environmentObject(Bars())
            .environmentObject(UserHandler())
    
    }
}

struct ExtractedView: View {
    @EnvironmentObject var bars: Bars
    @EnvironmentObject var userHandler : UserHandler
    @State var textFieldText : String = "Tell people about the vibe"
    @State var savedText: String = ""
    var body: some View {
        HStack{
            Button {
                savedText = bars.barSelected.liveReview
                bars.writeToFB(bar: bars.barSelected)
                
            } label: {
                Text("Post")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }.offset()
            
            TextEditor(text: $textFieldText)
                .frame(height: 100)
                .cornerRadius(10)
                .colorMultiply(Color.gray)
            
            
        }
    }
}
