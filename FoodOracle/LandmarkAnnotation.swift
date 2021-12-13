//
//  LandmarkAnnotation.swift
//  FoodOracle
//
//  Created by Aydin Battal on 2021-12-12.
//

import Foundation
import MapKit
import UIKit

final class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
