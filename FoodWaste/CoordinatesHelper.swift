//
//  CoordinatesHelper.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI
import CoreLocation

struct CoordinatesHelper {
    func getCoordinate( addressString : String,
                        completionHandler: @escaping(_ coordinate: CLLocationCoordinate2D, _ error: NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}

// usage
//getCoordinate(addressString: recipient.postalCode, completionHandler: {(coordinate, error) -> Void in
//    print("coordinate: \(coordinate)")
//
//
//    if error != nil {
//        print("error: \(String(describing: error))")
//    }
//
//})
