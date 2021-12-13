//
//  NearbyPlacesView.swift
//  FoodOracle
//
//Deep Patel - 991584445, Karan Patel - 991519115, Aydin Battal - 991521740
//

import SwiftUI
import MapKit

struct NearbyPlacesView: View {
    @State private var search: String = ""
    @State private var landmarks: [Landmark] = [Landmark]()
    @State private var tapped: Bool = false
    
    private func getNearbyLandmarks(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
                
            }
        }
    }
    
    func calculateOffset() -> CGFloat {
        if self.landmarks.count > 0 && !self.tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        } else if self.tapped {
            return 100
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    var body: some View {
        ZStack(alignment: .top){
            
            MapView(landmarks: self.landmarks)
            
            TextField("Search", text: $search, onEditingChanged: {
                _ in}){
                    //commit
                    self.getNearbyLandmarks()
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .offset(y:44)
            
            PlaceListView(landmarks: self.landmarks){
                //on tap
                self.tapped.toggle()
            }
                .animation(.spring(), value: UUID())
                .offset(y: calculateOffset())
        }
    }
}

struct NearbyPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyPlacesView()
    }
}


