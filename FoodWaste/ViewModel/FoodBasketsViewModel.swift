//
//  FoodBasketsViewModel.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import Foundation
import FirebaseFirestore

class FoodBasketsViewModel: ObservableObject {
    // get all food items
    // sort into each businesses
    // return
    
    @Published var foodBaskets = [FoodBasket]()
    
    private var db = Firestore.firestore()
    let FOOD_COLLECTION = "food"
    let BUSINESS_DETAILS = "business details"
    let calendar = Calendar.current
    
    private func getFoodItemsByBusiness(businessUEN: String, onComplete completionHandler: @escaping (_ isSuccess: Bool, _ foodItems: [FoodItem]) -> Void ) {
        db.collection(FOOD_COLLECTION).whereField("bizUen", isEqualTo: businessUEN).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completionHandler(true, [])
                return
            }
            
            let foodItems = documents.map { (queryDocumentSnapshot) -> FoodItem in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let quantity = data["quantity"] as? Int ?? 0
                let weight = data["weight"] as? String ?? ""
                let halal = data["halal"] as? Bool ?? false
                let expiry = (data["expiry"] as? Timestamp)?.dateValue() ?? Date()
                let bizUen = data["bizUen"] as? String ?? "NO_UEN"
                let postalCode = data["postalCode"] as? String ?? "000000"
                let id = queryDocumentSnapshot.documentID
                return FoodItem(id: id, name: name, quantity: quantity, weight: weight, halal: halal, expiry: expiry, bizUen: bizUen, postalCode: postalCode)
            }
            completionHandler(true, foodItems)
        }
    }
    
    func getBusinessInfo(onComplete completionHandler: ((_ isSuccess: Bool) -> Void)?) {
        db.collection(BUSINESS_DETAILS).addSnapshotListener { [self] (querySnapshot, error) in
            guard let bizDocuments = querySnapshot?.documents, bizDocuments.count != 0 else {
                print("No documents")
                completionHandler?(true) // return true if there's no donors, because it might be the case where no donor have come onboarded
                return
            }
            
            bizDocuments.forEach { (document) -> Void in
                let data = try! JSONSerialization.data(withJSONObject: document.data(), options: JSONSerialization.WritingOptions.prettyPrinted)
                let businessDetails = try! JSONDecoder().decode(BusinesssDetailsModel.self, from: data)
                print("\(businessDetails)")
                
                getFoodItemsByBusiness(businessUEN: businessDetails.uenNum) { successful, foodItems in
                    if (successful && !foodItems.isEmpty) { // only show the business if they have added something to donate
                        let expiryDates: [Int] = foodItems.map{(food) in
                            return calendar.dateComponents([.day], from: Date(), to: food.expiry).day!
                        }
                        // NOTE: only allow days for now
                        var expiryRange: String
                        if (expiryDates.min()! == expiryDates.max()!) {
                            expiryRange = "\(expiryDates.min()!) days"
                        } else {
                            expiryRange = "\(expiryDates.min()!) - \(expiryDates.max()!) days"
                        }
                        
                        foodBaskets.append(FoodBasket(business: businessDetails, foodItems: foodItems, expiryRange: expiryRange))
                    }
                }
            }
            completionHandler?(true)
        }
    }
}


struct FoodBasket: Identifiable {
    // add this id for it to be iterable
    var id: String = UUID().uuidString
    var business: BusinesssDetailsModel
    var foodItems: [FoodItem]
    var expiryRange: String
}
