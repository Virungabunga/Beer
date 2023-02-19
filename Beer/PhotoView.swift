//
//  PhotoView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-19.
//

import SwiftUI

struct PhotoView: View {
    @Environment(\.dismiss) private var dimiss
    @State private var photo = ImageData()
    @EnvironmentObject var bars  : Bars
    var bar : Bar
    var uiImage: UIImage
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                Spacer()
                TextField("Description", text: $photo.description)
                    .textFieldStyle(.roundedBorder)
                Text("By: \(photo.user)) on:\(photo.postedOn.formatted(date:.numeric, time: .standard))")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button("save") {
                        Task {
                            let succes = await bars.saveImage(bar: bar, photo: photo, image: uiImage)
                            if  succes {
                                dimiss()
                            }

                        }
                    }
                }
            }
        }
     
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(bar: Bar(id: "", name: "dude", latitude: 12.1, longitude: 23.3, phone: "123214", liveReview: "asdas"), uiImage: UIImage(named: "Dog") ?? UIImage())
            .environmentObject(Bars())
    }
}
