//
//  FoodItemModel.swift
//  FoodWaste
//
//  Created by fionna on 30/7/21.
//

import SwiftUI

struct FoodItem: Codable, Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var quantity: Int
    var weight: String
    var halal: Bool
    var expiry: Date
}
