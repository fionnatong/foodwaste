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
                return FoodItem(name: name, quantity: quantity)
            }
        }
    }
    
    func addFoodItem(name: String, quantity: Int) {
        db.collection(FOOD_COLLECTION).addDocument(data: ["name": name, "quantity": quantity])
    }
}

