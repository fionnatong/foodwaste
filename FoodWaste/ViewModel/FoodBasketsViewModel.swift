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
    private var businesses = [BusinesssDetailsModel]()
    private var foodItems = [FoodItem]()
    
    private var db = Firestore.firestore()
    let FOOD_COLLECTION = "food"
    let BUSINESS_DETAILS = "business details"
    let calendar = Calendar.current
    
    func getFoodItemsByBusiness(businessUEN: String) {
        db.collection(FOOD_COLLECTION).whereField("bizUen", isEqualTo: businessUEN).addSnapshotListener { (querySnapshot, error) in
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
                let bizUen = data["bizUen"] as? String ?? "NO_UEN"
                let postalCode = data["postalCode"] as? String ?? "000000"
                let id = queryDocumentSnapshot.documentID
                return FoodItem(id: id, name: name, quantity: quantity, weight: weight, halal: halal, expiry: expiry, bizUen: bizUen, postalCode: postalCode)
            }
        }
    }
    
    
    // return dummy info for now
    // @TODO update when weijian updates
    func getBusinessInfo() {
        db.collection(BUSINESS_DETAILS).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.businesses = documents.map { (queryDocumentSnapshot) -> BusinesssDetailsModel in
                let data = queryDocumentSnapshot.data()
                let id = data["id"] as? String ?? ""
                let bizName = data["bizName"] as? String ?? ""
                let uenNum = data["uenNum"] as? String ?? ""
                let bizAdd = data["bizAdd"] as? String ?? ""
                let postalCode = data["postalCode"] as? String ?? ""
                let monAvailable = data["monAvailable"] as? Bool ?? false
                let tueAvailable = data["tueAvailable"] as? Bool ?? false
                let wedAvailable = data["wedAvailable"] as? Bool ?? false
                let thursAvailable = data["thursAvailable"] as? Bool ?? false
                let friAvailable = data["friAvailable"] as? Bool ?? false
                let satAvailable = data["satAvailable"] as? Bool ?? false
                let sunAvailable = data["sunAvailable"] as? Bool ?? false
                let typesOfItemsSold = data["typesOfItemsSold"] as? Set<String> ?? Set<String>()
                // hardcode the values first
//                let startTime = data["startTime"] as? Set<String> ?? Set<String>()
//                let endTime = data["endTime"] as? Set<String> ?? Set<String>()
                return BusinesssDetailsModel(id: id, bizName: bizName, uenNum: uenNum, bizAdd: bizAdd, postalCode: postalCode, monAvailable: monAvailable, tueAvailable:tueAvailable, wedAvailable: wedAvailable, thursAvailable: thursAvailable, friAvailable: friAvailable, satAvailable: satAvailable, sunAvailable: sunAvailable, typesOfItemsSold:typesOfItemsSold, startTime: Date(timeIntervalSince1970: 1596412800), endTime: Date(timeIntervalSince1970: 1596448800))
            }
            
            self.foodBaskets = self.businesses.map{ (business) in
                // wait for all food items before returning
                self.getFoodItemsByBusiness(businessUEN: business.uenNum)
                
                // FIXME: the is not waiting for the food items to complete before returning
                let expiryDates: [Int] = self.foodItems.map{(food) in
                    return self.calendar.dateComponents([.day], from: Date(), to: food.expiry).day!
                }
                // NOTE: only allow days for now
                var expiryRange: String
                if (expiryDates.min() == expiryDates.max()) {
                    expiryRange = "\(String(describing: expiryDates.min())) days"
                }
                expiryRange = "\(String(describing: expiryDates.min())) - \(String(describing: expiryDates.max())) days"
                return FoodBasket(business: business, foodItems: self.foodItems, expiryRange: expiryRange)
            }
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
