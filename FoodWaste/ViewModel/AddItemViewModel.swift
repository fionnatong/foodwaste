//
//  AddItemViewModel.swift
//  FoodWaste
//
//  Created by See Yihui on 3/8/21.
//

import SwiftUI
import FirebaseFirestore

class AddItemViewModel: ObservableObject {
    @Published var foodItem: FoodItem = FoodItem(name: "", quantity: 0, weight: "", halal: true, expiry: Date())
    private var db = Firestore.firestore()
    let FOOD_COLLECTION = "food"
    
    func updateName(_ newValue: String) {
        foodItem.name = newValue
    }
    
    func updateQuantity(_ newValue: String) {
        foodItem.quantity = Int(newValue) ?? 0
    }
    
    func updateWeight(_ newValue: String) {
        foodItem.weight = newValue
    }
    
    func addFoodItem() {
        print("addFoodItem called with ", foodItem);
//        db.collection(FOOD_COLLECTION).addDocument(data: ["name": foodItem.name, "quantity": foodItem.quantity, "weight": foodItem.weight])
    }
}
