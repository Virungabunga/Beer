//
//  BarBigView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-17.
//

import SwiftUI
import UIKit
import PhotosUI
struct BarBigView: View {
    var friends: [User] = [User(id: "sda", name: "dude"),User(id: "sda", name: "dude"),User(id: "sda", name: "dude")]
    
    @EnvironmentObject var bars :Bars
    @EnvironmentObject var userHandler :UserHandler
    
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(colors: [.yellow, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 160)
      
            }
            
            VStack(alignment: .leading){
                
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
                  
                } label: {
                    Text("postlive reiew and pic")
                }.offset(y:50)
                
                
                ScrollView{
                  //  Text(bars.barSelected.liveReview)
                  
                    PhotoLibrary()
                }.offset(y:50)
                Spacer()
            }.padding()
        }
    }
}


struct BigBarView_Previews: PreviewProvider {
    static var previews: some View {
        BarBigView()
            .environmentObject(Bars())
            .environmentObject(UserHandler())
        
    }
}

struct ReviewView: View {
    @State private var image = UIImage()
    @State private var showSheet = false
    
    
    @EnvironmentObject var imageLoader :  ImageLoader
    @EnvironmentObject var bars: Bars
    @EnvironmentObject var userHandler : UserHandler
    @State var textFieldText : String = "Tell people about the vibe"
    @State var savedText: String = ""
    @State var review : Review
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    //Spara id för bar så vi vet vilken bild vi ska visa upp på respective bar
                    // sparar live review på baren coh skick upp i firestore
                    

                    review = Review(id: UUID(), text:textFieldText, imageId:imageLoader.path )
//                    bars.WriteReviewToBar(bar: bars.barSelected, review: review)
                    showSheet = false
                
                    
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
            Image(uiImage: imageLoader.selectedImage ?? UIImage(imageLiteralResourceName: "Dog"))
                .resizable()
                .cornerRadius(50)
                .frame(width: 100, height: 100)
                .background(Color.black.opacity(0.2))
                .aspectRatio(contentMode: .fill)
                .clipShape(Rectangle())
            
            Text("Change photo")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(16)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .onTapGesture {
                    showSheet = true
                }
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $showSheet) {
            // Pick an image from the photo library:
            ImagePicker(sourceType: .photoLibrary)
            
            
        }
        
    }
}
