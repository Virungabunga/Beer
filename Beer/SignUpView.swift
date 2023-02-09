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
    @State var ispresting  : Bool = false
    @State var showSignUp : Bool
    var body: some View{
        VStack{
            TextField("User Name", text: $userName)
            TextField("Password", text: $userPassword)
                .padding()
            
            Button(action:{
                signUp()
            }){
                Text("Sign Up")
            }
        }.fullScreenCover(isPresented: $ispresting) {
            ContentView()
        }
        
    }
    
    func signUp()  {
        Auth.auth().createUser(withEmail: userName, password: userPassword) { authResult, error in
            if (authResult?.user.uid == nil) { isSignedIn = true;  showSignUp = false}
        }
    }
}
