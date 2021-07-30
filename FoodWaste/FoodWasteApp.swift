//
//  FoodWasteApp.swift
//  FoodWaste
//
//  Created by fionna on 28/7/21.
//

import SwiftUI
import Firebase

@main
struct FoodWasteApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
