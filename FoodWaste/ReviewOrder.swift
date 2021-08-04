//
//  ReviewOrder.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI

// @TODO update hardcoded date after preivous page is done
struct ReviewOrder: View {
    var business: BusinesssDetailsModel
    var foodItems: [FoodItem]
    var selectedFoodItems: Set = Set<String>()
    var selectedDate: Date
    @State private var renderableSelectedFoodItems: [FoodItem] = []
    
    let calendar = Calendar.current
    
    func initFoodItems() {
        renderableSelectedFoodItems = foodItems.filter { item in
            return selectedFoodItems.contains(item.id!)
        }
    }
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: nil) {
                    Text("Review").font(CustomFont.headerOne)
                        .padding(.bottom, 16)
                    
                    ReviewDonorDetails(business: business)
                        .padding(.bottom, 16)
                    
                    ReviewSelecedItems(business: business, foodItems: foodItems, renderableItems: renderableSelectedFoodItems, selectedFoodItems: selectedFoodItems)
                        .padding(.bottom, 16)
                        
                    
                    ReviewCollectionDate()
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                initFoodItems()
            }
        }
    }
}

struct ReviewOrder_Previews: PreviewProvider {
    static var previews: some View {
        ReviewOrder(business: BusinesssDetailsModel(id: "12345", bizName: "Business Name", uenNum: "12345", bizAdd: "My address", postalCode: "611138", monAvailable: true, tueAvailable: false, wedAvailable: true, thursAvailable: false, friAvailable: true, satAvailable: false, sunAvailable: true, typesOfItemsSold: ["Cereal"], startTime: Date(), endTime: Date()), foodItems: [FoodItem(id: "1234", name: "Royal Rice", type: "Groceries", quantity: 1, weight: "12kg", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111")], selectedFoodItems: ["1234"], selectedDate: Date())
    }
}


struct ReviewDonorDetails: View {
    var business: BusinesssDetailsModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack (alignment: .leading){
                Text("Donor Details")
                    .font(CustomFont.headerThree)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(CustomFont.bodyTwoRegular)
                        .foregroundColor(Color("gray-two"))
                    Text("\(business.bizName)")
                        .font(CustomFont.headerFour)
                        .foregroundColor(Color.black)
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Address")
                        .font(CustomFont.bodyTwoRegular)
                        .foregroundColor(Color("gray-two"))
                    Text("\(business.bizAdd)")
                        .font(CustomFont.headerFour)
                        .foregroundColor(Color.black)
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Distance from Organisation")
                        .font(CustomFont.bodyTwoRegular)
                        .foregroundColor(Color("gray-two"))
                    Text("0.80 km")
                        .font(CustomFont.headerFour)
                        .foregroundColor(Color.black)
                }
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: CustomColor.shadow, radius: 12, x: 0, y: 4)
    }
}

struct ReviewSelecedItems: View {
    var business: BusinesssDetailsModel
    var foodItems: [FoodItem]
    var renderableItems: [FoodItem]
    var selectedFoodItems: Set = Set<String>()
    let calendar = Calendar.current
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack (alignment: .leading){
                HStack{
                    Text("Selected Items")
                        .font(CustomFont.headerThree)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                    Spacer()
                    
                    // not the best solution for edit. will create many layers
                    NavigationLink("Edit", destination: BusinessFoodView(business: business, foodItems: foodItems, initialSelectedFoodItems: selectedFoodItems))
                }
                
                
                ForEach(renderableItems) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(item.name)")
                                .font(CustomFont.headerFour)
                                .foregroundColor(Color.black)
                            Spacer()
                            Text("x \(item.quantity)")
                                .font(CustomFont.bodySemibold)
                                .foregroundColor(CustomColor.primary)
                        }

                        HStack {
                            Text("\(item.weight.isEmpty ? "No weight specified" : item.weight) • \(item.halal ? "Halal" : "Non-halal")")
                                .font(CustomFont.caption)
                                .foregroundColor(Color("gray-two"))
                            Spacer()
                            Text("Expires in \(calendar.dateComponents([.day], from: Date(), to: item.expiry).day!) days")
                                .font(CustomFont.caption)
                                .padding(4)
                                .frame(alignment: .trailing)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(CustomColor.primary)
                                )
                        }
                        .padding(.top, 8)
                    }
                    .padding(.bottom, 20)
                }
                
                Text("Total: \(getTotalWeight(items: renderableItems))kg • \(renderableItems.count) \(renderableItems.count > 1 ? "items" : "item")")
                    .font(CustomFont.caption)
                    .foregroundColor(Color("gray-two"))
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: CustomColor.shadow, radius: 12, x: 0, y: 4)
    }
}

struct ReviewCollectionDate: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack (alignment: .leading){
                Text("Collection Date")
                    .font(CustomFont.headerThree)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Friday, 6 August 2021")
                        .font(CustomFont.headerFour)
                        .foregroundColor(Color.black)
                        .padding(.bottom, 8)
                    Text("9:30am - 10:00am")
                        .font(CustomFont.bodyRegular)
                        .foregroundColor(Color.black)
                }
                .padding(.bottom, 20)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: CustomColor.shadow, radius: 12, x: 0, y: 4)
    }
}

// FIXME should this be written here?
func getTotalWeight (items: [FoodItem]) -> String {
    var totalWeight: Float = 0.0;
    items.forEach { (item) in
        totalWeight = totalWeight + ((item.weight as NSString).floatValue * Float(item.quantity));
    }
    
    return String(totalWeight)
}
