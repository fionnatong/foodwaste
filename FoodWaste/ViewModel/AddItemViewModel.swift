//
//  AddItemViewModel.swift
//  FoodWaste
//
//  Created by See Yihui on 3/8/21.
//

import SwiftUI
import FirebaseFirestore

class AddItemViewModel: ObservableObject {
    @Published var foodItem: FoodItem
    private var db = Firestore.firestore()
    let FOOD_COLLECTION = "food"
    
    init (initialValue: FoodItem?){
        guard let initialItem = initialValue  else {
            self.foodItem = FoodItem(name: "", quantity: 0, weight: "", halal: false, expiry: Date())
            return
        }
        
        self.foodItem = initialItem
    }
    
    func updateName(_ newValue: String) {
        foodItem.name = newValue
    }
    
    func updateQuantity(_ newValue: String) {
        foodItem.quantity = Int(newValue) ?? 0
    }
    
    func updateWeight(_ newValue: String) {
        foodItem.weight = newValue
    }
    
    func addFoodItem(onCompleted: @escaping (_ isSuccess: Bool) -> Void) {
        print("addFoodItem called with ", foodItem);
        var ref: DocumentReference? = nil
        let mockExpiryDate = Date(timeIntervalSinceNow: 864000) // mock (TODAY+10) date until datepicker is implemented
        
        ref = db.collection(FOOD_COLLECTION).addDocument(data: ["name": foodItem.name, "quantity": foodItem.quantity, "weight": foodItem.weight, "halal": foodItem.halal, "expiry": mockExpiryDate]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                onCompleted(false)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                onCompleted(true)
            }
        }
    }
}
