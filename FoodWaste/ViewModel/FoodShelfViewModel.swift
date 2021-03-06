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
        let businessUEN = UserDefaults.standard.value(forKey: "OnboardedBizUen") as? String ?? ""
        db.collection(FOOD_COLLECTION).whereField("bizUen", isEqualTo: businessUEN).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.foodItems = documents.map { (queryDocumentSnapshot) -> FoodItem in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let type = data["type"] as? String ?? ""
                let quantity = data["quantity"] as? Int ?? 0
                let weight = data["weight"] as? String ?? ""
                let halal = data["halal"] as? Bool ?? false
                let expiry = (data["expiry"] as? Timestamp)?.dateValue() ?? Date()
                let bizUen = data["bizUen"] as? String ?? "NO_UEN"
                let postalCode = data["postalCode"] as? String ?? "000000"
                let id = queryDocumentSnapshot.documentID
                return FoodItem(id: id, name: name, type: type, quantity: quantity, weight: weight, halal: halal, expiry: expiry, bizUen: bizUen, postalCode: postalCode )
            }
        }
    }
}

