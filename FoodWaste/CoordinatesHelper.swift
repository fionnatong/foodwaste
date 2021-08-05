//
//  CoordinatesHelper.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI
import CoreLocation

struct CoordinatesHelper {
    static func getCoordinate( addressString : String,
                        completionHandler: @escaping(_ coordinate: CLLocationCoordinate2D?, _ hasError: Bool) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, false)
                    return
                }
            }
                
            completionHandler(nil, true)
        }
    }
    
    static func getDistance(pointOne: CLLocationCoordinate2D, pointTwo: CLLocationCoordinate2D) -> Double {
        let locationOne = CLLocation(latitude: pointOne.latitude, longitude: pointOne.longitude)
        let locationTwo = CLLocation(latitude: pointTwo.latitude, longitude: pointTwo.longitude)
        // distance is in meters
        return locationOne.distance(from: locationTwo) / 1000
    }
}
