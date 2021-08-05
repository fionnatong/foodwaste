//
//  DoubleExtension.swift
//  FoodWaste
//
//  Created by See Yihui on 5/8/21.
//

import Foundation
extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
