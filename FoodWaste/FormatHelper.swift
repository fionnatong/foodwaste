//
//  FormatHelper.swift
//  FoodWaste
//
//  Created by See Yihui on 5/8/21.
//

import Foundation

struct FormatHelper {
    
    static func getWeightInKilograms(weight: String) -> String {
        let weightInInt = Double(weight) ?? 1.0
        return String(weightInInt / 1000)
    }

}
