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
    @MainActor 
    let db = Firestore.firestore()

    @Published var currentUser : User?
    @Published var friendList : [User]
    @Published var userList : [User]
    var friendrequestList : [User]?
    var friend: User
    
    init(currentUser: User, friendList: [User] = [User](), userList: [User] = [User](), friend : User) {
        self.currentUser = currentUser
        self.friendList = []
        self.userList = []
        self.friend = friend
    }
    
    init() {
        
        self.currentUser = nil
        self.friendList = []
        self.userList = []
        self.friend = User(id: "", name: "")
        
    }
    

//    func sendFriendReq() {
//
//        if (
//      ((   userList.first { User in
//            User.id == friend.id
//      }) != nil)){
//            if let currentUser = currentUser{
//                friend.friendReqList?.append(currentUser)
//                writeToDb(user: currentUser, collection: "Users")
//            }
//        }
//
//
//
//    }
//
//    func acceptFriendReq()     {
//
//        if (
//            ((   userList.first { User in
//                User.id == friend.id
//            }) != nil)) {
//            if let currentUser = currentUser{
//                friend.friendReqList?.append(currentUser)
//                writeToDb(user: currentUser, collection: "Users")
//            }
//
//
//        }
//    }
        
     
    
//    func removeFriend(userId:String)     {
//
//    }
 
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
        //måste ha userlistHÄr
        print(userList)
        
            if let user = Auth.auth().currentUser{

                currentUser = userList.first { $0.id == user.uid}
                
                			
            } else {
                print("No one signed in")
            }
    }
}



