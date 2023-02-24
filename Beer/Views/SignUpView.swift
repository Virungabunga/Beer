//
//  SignUpView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-02.
//
import SwiftUI
import Foundation
import FirebaseAuth

struct SignUpView : View{
    
    @State var userName : String = ""
    @State var userPassword : String = ""
    @State var showLoginView  : Bool = false
    @State var showSignUp : Bool
    @State var currentUser : User?
    @EnvironmentObject var userHandler : UserHandler
    @State var isSignedIn = false
    var body: some View{
        NavigationView {
            ZStack{
                Image("background")
                         .resizable()
                         .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    TextField("User Name", text: $userName).padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange, lineWidth: 2)
                        }.padding(.horizontal)
                        .padding()
                    
                    SecureField("Password", text: $userPassword).padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange, lineWidth: 2)
                        }.padding(.horizontal)
                        .padding()
                    
                    Button {
                        signUp()
                      
                    } label: {
                        Text("Sign up")
                            .font(. title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [.yellow, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing)
                    )
                    .cornerRadius(20)
                    .padding()
                    
                }.fullScreenCover(isPresented: $showLoginView) {
                
                    ContentView()
                }
                
                
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showLoginView = true
                        } label: {
                            Text("Back")
                        }

                    
                    }
                }
        }
        
    }
    
    
// Skapar upp användare och sparar i en lista på firestore g
    func signUp()  {
        Auth.auth().createUser(withEmail: userName, password: userPassword) { authResult, error in
            if   let id = authResult?.user.uid {
                
           
                    userHandler.writeToDb(user: User(id: id, name: userName), collection: "Users")

                
                isSignedIn = true;
                
                
            }
        }
        
    }
    

}
