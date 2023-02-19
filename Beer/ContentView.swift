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
    @EnvironmentObject var userHandler : UserHandler
    
    var body: some View{
        NavigationView {
            MapView()
        }
    }
}


struct MapView : View{
    
    @EnvironmentObject var locationManager : LocationManager
    @EnvironmentObject var userHandler : UserHandler
    @State var showBarView = false
    
    @EnvironmentObject var bars :Bars
    
    var body: some View{
        ZStack{
            
            VStack {
                
                Map(coordinateRegion: $locationManager.region,
                    interactionModes: [.all],
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow), //.constant(.follow) följer allltid  när jag trycker på anotaions
                    annotationItems: bars.bars) { bar in // SÄTT TiLL BINDING?
                    MapAnnotation(coordinate:CLLocationCoordinate2D(latitude: bar.latitude, longitude: bar.longitude) , anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                        MapPinView().onTapGesture() {
                            bars.barSelected = bar
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
            
            BarView().opacity(showBarView ? 0 : 1)
            
            
        }.ignoresSafeArea()
        
        
    }
    
    
}

struct BarView  : View {
    @EnvironmentObject var bars :Bars
    @EnvironmentObject var userHandler : UserHandler
    // Du ska skapa binding variabel som visar vilka vänner är vid bar???
    
    
    var body : some View {
        //Fixaa öl glas klick
        NavigationLink {
            BarBigView()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [.yellow, .red],                   startPoint: .topLeading,                   endPoint: .bottomTrailing))
                    .frame(width: 300, height: 100)
                VStack{
                    Text(bars.barSelected.name).scaledToFit()
                        .foregroundColor(.black)
                    HStack{
                        Text(bars.barSelected.liveReview)
                            .foregroundColor(.black)
                        Spacer()
                        //If frends turn turn gren and show up
                        Image(systemName:"figure.socialdance" )
   
                        
                    }.frame(width: 200)
                
                    
                }
            }.padding(.top,600)
              
  
        }  .frame(width: 300, height: 100)
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

struct ContentView_Previews: PreviewProvider {
    @Binding var isSignedIn : Bool
    static var previews: some View {
        ContentView()
            .environmentObject(LocationManager())
            .environmentObject(UserHandler())
            .environmentObject(Bars())
    }
    
}
