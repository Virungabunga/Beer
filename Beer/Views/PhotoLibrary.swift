//
//  PhotoLibrary.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-20.
//

import SwiftUI

struct PhotoLibrary: View {
    @EnvironmentObject var imageLoader : ImageLoader
    @EnvironmentObject var userHandler : UserHandler
    @EnvironmentObject var bars : Bars
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(
                    repeating: .init(.adaptive(minimum: 100), spacing: 1),
                    count: 2
                ),
                spacing: 1
            ) {
            
                ForEach(imageLoader.barReviewPica) { image in
                    if (bars.barSelected.id == image.barId){
                        Image(uiImage: image.image ?? UIImage(imageLiteralResourceName: "Dog"))
                            .resizable()
                        }
                  
                }.frame(width: 100, height: 100)
            }
            
        }.task {
            imageLoader.retrivePhotos()
            bars.listenToFirestore()
        }
            
        
        
    }
}

struct PhotoLibrary_Previews: PreviewProvider {
    static var previews: some View {
        PhotoLibrary()
    }
}
