//
//  LoginView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-02.
//

import SwiftUI
import FirebaseAuth
struct LoginView: View {
  //  @State private var isPresenting = false
    @Binding var isSignedIn : Bool
    @State var userName : String = ""
    @State var userPassword : String = ""
    @State var showSignUp = false
    
    var body: some View {
        VStack{
            TextField("User Name", text: $userName)
               
            TextField("Password", text: $userPassword)
                .padding()
            
            Button(action:{
                Login(userName: userName , userPassword: userPassword)
            }){
                Text("Login In")
            }
            Button(action:{
               showSignUp = true
            }){
                Text("SignUP")
            }
        }.fullScreenCover(isPresented: $showSignUp) {
            SignUpView(isSignedIn: $isSignedIn, showSignUp: showSignUp)
        }
    }
    
    func Login(userName: String,userPassword: String)   {
        Auth.auth().signIn(withEmail: userName, password: userPassword) {  authResult, error in
            // guard let strongSelf = self else { return }
            if (authResult?.user.uid == nil) { isSignedIn = true }
            
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
