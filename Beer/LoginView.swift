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
        NavigationView {
            
            ZStack{
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 15){
                    Spacer()
                    TextField("User Name", text: $userName).padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange, lineWidth: 2)
                        }.padding(.horizontal)
                    
                    SecureField("Password", text: $userPassword).padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.orange, lineWidth: 2)
                        }.padding(.horizontal)
                    
                    Button {
                        Login(userName: userName , userPassword: userPassword)
                    } label: {
                        Text("Sign In")
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
                    
                    Button {
                        showSignUp = true
                    } label: {
                        
                        Text("Sign up")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal,150)
                    Spacer()
                }.fullScreenCover(isPresented: $showSignUp) {
                    SignUpView(isSignedIn: $isSignedIn, showSignUp: showSignUp)
                }
            }
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
