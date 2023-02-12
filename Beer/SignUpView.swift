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
    @Binding var isSignedIn : Bool
    @State var userName : String = ""
    @State var userPassword : String = ""
    @State var showLoginView  : Bool = false
    @State var showSignUp : Bool
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
                            .font(.title2)
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
    
    func signUp()  {
        Auth.auth().createUser(withEmail: userName, password: userPassword) { authResult, error in
            if (authResult?.user.uid == nil) { isSignedIn = true;  showSignUp = false}
        }
    }
}
