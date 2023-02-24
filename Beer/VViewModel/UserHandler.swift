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
import CoreLocation

class UserHandler : ObservableObject  {
    
    @MainActor
    let db = Firestore.firestore()
    
    @Published var currentUser : User
    @Published var friendList : [User]
    @Published var userList : [User]
    @Published var friendrequestList : [User]

    var friendId : String = "3BmwQVc7d3ZPN53nCwUJMbMSN473"
    
    init(currentUser: User, friendList: [User] = [User](), userList: [User] = [User](), friend : User) {
        self.currentUser = currentUser
        self.friendList = []
        self.userList = []

        self.friendrequestList = []
    }
    
    init() {
        
        self.currentUser = User(id: "", name:   ""  )
        self.friendList = []
        self.userList = []
        self.friendrequestList = []
    }
    
    
    func sendFriendReq() {
        
        
        if let userCurrent = Auth.auth().currentUser{
            
            do {
                
                try db.collection("Users").document(friendId).collection("friendRequest").document(userCurrent.uid).setData(from: currentUser)
            } catch {
                print(error)
            }
        }
        
        
        
    }
    
    
    func listenToFriendReq()    {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        db.collection("Users").document(currentUserId).collection("friendRequest").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                
                for document in snapshot.documents {
                    
                    let result = Result {
                        try document.data(as: User.self)
                    }
                    switch result  {
                    case .success(let user)  :
                        self.friendrequestList.append(user)
                        
                        print(user.self)
                        
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    //    func removeFriend(userId:String)     {
    //
    //    }
    
    //
    //    func friendAtBar(bar:Bar) -> Bool {
    //
    //
    //        for friend in friendList {
    //
    //            if (friend.isAtLocation) {
    //                return true
    //            }
    //            return true
    //        }
    //
    //    }
    //
    //
    
    func writeToDb(user:User, collection: String) {
        
        if let currentUser = Auth.auth().currentUser{
            do {
                
                try db.collection(collection).document(currentUser.uid).setData(from: user)
            } catch {
                print(error)
            }
        }
    }
    
    func listenToFirestore(collection:String) {
        db.collection(collection).addSnapshotListener { snapshot, err in
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
                     
                        
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
                    }
                }
                self.setCurrentUser(userList: self.userList)
            }
        }
    }
    
    
    func setCurrentUser(userList: [User] )  {
        //SÄTT USER FRÅN INLOGG
        //måste ha userlistHÄr
        print(userList)
        
        if let user = Auth.auth().currentUser{
            
            currentUser = userList.first { $0.id == user.uid}!
           
            
        } else {
            print("No one signed in")
        }
    }
}



