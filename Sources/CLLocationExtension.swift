//
//  CLLocationExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 06/05/21.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    var isGPSIsAccurate:Bool {
        return self.horizontalAccuracy <= 30
    }
    var convertTo2DCoordinates:CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
    }
}
extension CLLocationCoordinate2D {
    
    func distance(to:CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return from.distance(from: to)
    }
}
