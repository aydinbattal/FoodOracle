//
//  MapView.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-12-12.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationHelper: LocationHelper
    
    var body: some View {
        VStack{
            
            if(self.locationHelper.currentLocation != nil){
                //show current location on map
                MyMap(location: self.locationHelper.currentLocation!)
            }else{
                Text("Obtaining user location...")
            }
        }
        .onAppear(){
            self.locationHelper.checkPermission()
        }
    }//body
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct MyMap : UIViewRepresentable{
    private var location: CLLocation
    @EnvironmentObject var locationHelper: LocationHelper
    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    
    init(location:CLLocation){
        self.location = location
    }
    func makeUIView(context: Context) -> MKMapView {
        let sourceCoordinates : CLLocationCoordinate2D
        let region: MKCoordinateRegion
        
        if(self.locationHelper.currentLocation != nil){
            sourceCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387024)
        }
        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        let map = MKMapView(frame: .infinite)
        
        map.mapType = MKMapType.standard
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.isUserInteractionEnabled = true
        map.setRegion(region, animated: true)
        self.locationHelper.addPinToMapView(mapView: map, coordinates: sourceCoordinates, title: "You're Here")
        
        return map
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //update map to show current location
        let sourceCoordinates : CLLocationCoordinate2D
        let region: MKCoordinateRegion
        
        if(self.locationHelper.currentLocation != nil){
            sourceCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourceCoordinates = CLLocationCoordinate2D(latitude: 43.642567, longitude: -79.387024)
        }
        
        region = MKCoordinateRegion(center: sourceCoordinates, span: span)
        
        uiView.setRegion(region, animated: true)
        self.locationHelper.addPinToMapView(mapView: uiView, coordinates: sourceCoordinates, title: "You're Here")

        
    }
    typealias UIViewType = MKMapView
}

