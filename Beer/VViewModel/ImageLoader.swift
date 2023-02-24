//
//  ImageLoader.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-20.
//
import SwiftUI
import Foundation
import Swift
import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore


class ImageLoader : ObservableObject {

    @Published var barReviewPica : [ImageData] = []
    @Published var profilImage : UIImage = UIImage()
    @Published var retrivedImages : [ImageData] = []
    @Published var selectedImage : UIImage?
    @Published var path : String = ""
    // ladd upp bild till storage och sparar reference i firestoer
    func upload() {
        guard selectedImage != nil else {
            return
            
        }
        if  let user = Auth.auth().currentUser{
            let storageRef = Storage.storage().reference()
            let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
            
            guard imageData != nil else {return}
            path = "images/\(user.uid)/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            let uploadTask = fileRef.putData(imageData!, metadata: nil) { metaData, error in
                if error == nil && metaData != nil {
                    let db = Firestore.firestore()
                    let imagedata = ImageData(imageUrlString: self.path)
                    db.collection("images").document().setData(["url" : self.path])
                    
                }
            }
            
        }
    }
    
    
    func retrivePhotos()  {
      
        if  let user = Auth.auth().currentUser{
            let db = Firestore.firestore()
            db.collection("images").getDocuments { snapshot, error in
        
                var paths = [String]()
                var barid = [String]()
                
                for doc in snapshot!.documents{	
                    paths.append(doc["url"] as! String)
                }
                for path in paths {
                    let storageRef = Storage.storage().reference()
                    let fileRef = storageRef.child(path)
                    fileRef.getData(maxSize: 5*1024*1024) { data,   error in
                        if (error == nil && data != nil ) {
                    
                            if let image = UIImage(data: data!){
                                
                                DispatchQueue.main.async {
                                    let completeImage = ImageData(id: path, image: image)
                                    self.retrivedImages.append(completeImage)
    
                                }
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

