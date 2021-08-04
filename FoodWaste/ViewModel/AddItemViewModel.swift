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
            self.foodItem = FoodItem(name: "",
                                     quantity: 0,
                                     weight: "",
                                     halal: false,
                                     expiry: Date(),
                                     bizUen: (UserDefaults.standard.value(forKey: "OnboardedBizUen") as? String) ?? "NO_UEN",
                                     postalCode: (UserDefaults.standard.value(forKey: "OnboardedBizPostalCode") as? String) ?? "000000")
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
    
    func updateId(_ newValue: String) {
        foodItem.id = newValue
    }
    
    func addFoodItem(onCompleted: @escaping (_ isSuccess: Bool) -> Void) {
        print("addFoodItem called with ", foodItem);
        var ref: DocumentReference? = nil
        let mockExpiryDate = Date(timeIntervalSinceNow: 864000) // mock (TODAY+10) date until datepicker is implemented
        foodItem.expiry = mockExpiryDate
        
        // new food item
        guard foodItem.id != nil else {
            ref = db.collection(FOOD_COLLECTION).addDocument(data: ["name": foodItem.name, "quantity": foodItem.quantity, "weight": foodItem.weight, "halal": foodItem.halal, "expiry": mockExpiryDate, "bizUen": foodItem.bizUen, "postalCode": foodItem.postalCode]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    onCompleted(false)
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    self.updateId(ref!.documentID)
                    onCompleted(true)
                }
            }
            return;
        }
        
        // update existing food item
        db.collection(FOOD_COLLECTION).document(foodItem.id!).updateData(["name": foodItem.name, "quantity": foodItem.quantity, "weight": foodItem.weight, "halal": foodItem.halal, "expiry": mockExpiryDate]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                onCompleted(false)
            } else {
                print("Document with id \(self.foodItem.id!) updated")
                onCompleted(true)
            }
        }
        
    }
}
