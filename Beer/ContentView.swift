//
//  ContentView.swift
//  Beer
//
//  Created by Oscar Sparrman on 2023-02-01.
//

import SwiftUI
import _MapKit_SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    @State var signedIn = false
    @State var showSignUp : Bool = false
    
    var body: some View{
        
        if !signedIn {
            LoginView(isSignedIn: $signedIn)
        } else  if (showSignUp == false && signedIn == true) {
            MapView()
        }
        
        
    }
}



struct MapView : View{
    var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3323341, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    @StateObject var bars = Bars()
    
    var body: some View{
        ZStack{
            
            VStack {
                
                Map(coordinateRegion: $region,
                    interactionModes: [.all],
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow),
                    annotationItems: bars.bars) { bar in
                    MapAnnotation(coordinate:bar.placeMark.coordinate , anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                        MapPinView(bar: bar)
        
                    }
                    
                }
                
            }.onAppear(perform: locationManager.startLocationUpdates)
            Button(action: {
                bars.fetchData(locationManager: locationManager)
            }) {
                
                Image("beer")
                    .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    .resizable()
                    .frame(width: 50, height: 50)
                
            }
            
        }
    }
    
}
struct MapPinView: View {
    var bar : Bar
    
    var body: some View {
        VStack {
            Image("beer")
                .resizable()
                .frame(width: 30, height: 30)
            //            Text(bar.name.description)
        }
    }
    
 
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
