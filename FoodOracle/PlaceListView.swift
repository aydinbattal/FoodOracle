//
//  PlaceListView.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-12-12.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks: [Landmark]
    var onTap: () -> ()
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
            }.frame(width: UIScreen.main.bounds.size.width, height: 60)
                .background(Color.gray)
                .gesture(TapGesture()
                    .onEnded(self.onTap)
                )
            List {
                ForEach(self.landmarks, id: \.id) {landmark in
                    VStack(alignment: .leading) {
                        Text(landmark.name)
                            .fontWeight(.bold)
                        
                        Text(landmark.title)
                    
                    }
                    .onTapGesture {
                        redirectToGPS(lat: landmark.coordinate.latitude, lon: landmark.coordinate.longitude, name: landmark.name)
                    }
                }
            }.animation(nil, value: UUID())
        }.cornerRadius(10)
    }
    
    func redirectToGPS(lat: CLLocationDegrees, lon: CLLocationDegrees, name: String){
        let regionDistance: CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(lat, lon)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
}

//struct PlaceListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceListView()
//    }
//}
