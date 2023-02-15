//
//  UserHandler.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-13.
//

import Foundation
import FirebaseAuth
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseCore
import  Firebase

class UserHandler : ObservableObject  {
    let db = Firestore.firestore()
    @Published var currentUser : User?
    @Published var friendList = [User]()
    @Published var userList = [User]()
    
    
   
    
    func WriteTiDb(user:User) {
        if let currentUser = Auth.auth().currentUser{
            do {
                
                try db.collection("Users").document(currentUser.uid).setData(from: user)
            } catch {
                print(error)
            }
        }
    }

    func listenToFirestore() {
            db.collection("Users").addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                
                if let err = err {
                    print("Error getting document \(err)")
                } else {
//                    items.removeAll()
                    for document in snapshot.documents {

                        let result = Result {
                            try document.data(as: User.self)
                        }
                        switch result  {
                        case .success(let user)  :
                            self.userList.append(user)
                            self.setCurrentUser(userList: self.userList)
                        case .failure(let error) :
                            print("Error decoding item: \(error)")
                        }
                    }
                }
            }
        }

    
    func setCurrentUser(userList: [User] )  {
        //SÄTT USER FRÅN INLOGG
        //felsöka hitta användare 
        print(userList)
        
            if Auth.auth().currentUser != nil {
                
                currentUser = userList.first { $0.id == Auth.auth().currentUser?.uid}
                
            } else {
                print("No one signed in")
            }
    }
}



