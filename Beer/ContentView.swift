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
    @EnvironmentObject var locationManager : LocationManager
    @EnvironmentObject var bars :Bars
    @State var signedIn = false
    @State var showSignUp : Bool = false
    @EnvironmentObject var userHandler : UserHandler
    

    var body: some View{
        
        if !signedIn {
            LoginView(isSignedIn: $signedIn)
        } else  if (showSignUp == false && signedIn == true) {
       
            MapView().onAppear() {

                bars.listenToFirestore()
                userHandler.listenToFirestore()
            }
        }
        
        
    }
}
    
    
    struct MapView : View{
        @EnvironmentObject var locationManager : LocationManager
        @EnvironmentObject var userHandler : UserHandler
        @State var showBarView = false
        @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3323341, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        @EnvironmentObject var bars :Bars
        @State var barSelected = Bar(id: "",name: "test", latitude: 0.0, longitude: 0.0, phone: "test",liveReview: "test")
        var body: some View{
            ZStack{
                
                VStack {
                    
                    Map(coordinateRegion: $region,
                        interactionModes: [.all],
                        showsUserLocation: true,
                        userTrackingMode: .constant(.follow),
                        annotationItems: bars.bars) { bar in // SÄTT TiLL BINDING
                        MapAnnotation(coordinate:CLLocationCoordinate2D(latitude: bar.latitude, longitude: bar.longitude) , anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                            MapPinView().onTapGesture(count: 1) {
                                barSelected = bar
                                showBarView.toggle()
                                
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }.onAppear(perform: locationManager.startLocationUpdates)
                Button(action: {
                    bars.fetchDataFromMaps(locationManager: locationManager)
                
                }) {
                    
                    Image("beer")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                }
                Spacer(minLength: 60)
            if let user = userHandler.currentUser{
                BarView(barSelected:$barSelected,currentUser: user).opacity(showBarView ? 0 : 1)
                
            }
            }.ignoresSafeArea()
            
            
        }
        
        
    }
    
    struct BarView  : View {
        @Binding var barSelected : Bar
        // Du ska skapa binding variabel som visar vilka vänner är vid bar???
        var currentUser: User

        
        
        
        var body : some View {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color("beerColor"))
                    .frame(width: 300, height: 100)
                VStack{
                    Text(barSelected.name).scaledToFit()
                    HStack{
                        Text(barSelected.liveReview)
                        
                        Image(systemName:"figure.socialdance" )
//                        List{
//                            ForEach(currentUser.friendList, id: \.self) { friend in
//                                Text(friend)
//
//                            }
//
//                        }
                    }
                }
            }.padding(.top,600)
        }
        
    }
    
    struct MapPinView: View {
        
        var body: some View {
            VStack {
                Image("beer")
                    .resizable()
                    .frame(width: 30, height: 30)
                //            Text(bar.name.description)
            }
        }
        
        
        
    }
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
