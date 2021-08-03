//
//  FoodShelfViewModel.swift
//  FoodWaste
//
//  Created by fionna on 30/7/21.
//

import Foundation
import FirebaseFirestore

class FoodShelfViewModel: ObservableObject {
    @Published var foodItems = [FoodItem]()
    private var db = Firestore.firestore()
    let FOOD_COLLECTION = "food"
    let calendar = Calendar.current
    
    func getFoodItems() {
        db.collection(FOOD_COLLECTION).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.foodItems = documents.map { (queryDocumentSnapshot) -> FoodItem in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let quantity = data["quantity"] as? Int ?? 0
                let weight = data["weight"] as? String ?? ""
                let halal = data["halal"] as? Bool ?? false
                let expiry = (data["expiry"] as? Timestamp)?.dateValue() ?? Date()
                return FoodItem(name: name, quantity: quantity, weight: weight, halal: halal, expiry: expiry)
            }
        }
    }
}

