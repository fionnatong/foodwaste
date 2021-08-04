//
//  RecipientModel.swift
//  FoodWaste
//
//  Created by See Yihui on 3/8/21.
//

import SwiftUI

struct Recipient: Codable, Identifiable {
    var id: String?
    var organisationName: String
    var uenNumber: String
    var address: String
    var postalCode: String
}
