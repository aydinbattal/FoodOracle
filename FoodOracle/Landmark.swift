//
//  Landmark.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-12-12.
//

import Foundation
import MapKit

struct Landmark {
    let placemark: MKPlacemark
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        self.placemark.name ?? ""
    }
    
    var title: String {
        self.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        self.placemark.coordinate
    }
}
