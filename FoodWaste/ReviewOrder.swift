//
//  ReviewOrder.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI

// @TODO update hardcoded date after preivous page is done
struct ReviewOrder: View {
    var basket: FoodBasket
    var selectedFoodItems: Set = Set<String>()
    var selectedDate: Date
    @State private var renderableSelectedFoodItems: [FoodItem] = []
    @State private var showConfirmation: Bool = false
    @State private var selectedFoodWeight: String = ""
    
    let calendar = Calendar.current
    
    func initFoodItems() {
        renderableSelectedFoodItems = basket.foodItems.filter { item in
            return selectedFoodItems.contains(item.id!)
        }
        
        selectedFoodWeight = getTotalWeight(items: renderableSelectedFoodItems)
    }
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: nil) {
                    Text("Review").font(CustomFont.headerOne)
                        .padding(.bottom, 16)
                    
                    ReviewDonorDetails(business: basket.business)
                        .padding(.bottom, 16)
                    
                    ReviewSelecedItems(basket: basket, renderableItems: renderableSelectedFoodItems, selectedFoodItems: selectedFoodItems, totalWeight: selectedFoodWeight)
                        .padding(.bottom, 16)
                        
                    
                    ReviewCollectionDate(basket: basket, selectedFoodItems: selectedFoodItems, selectedDate: selectedDate)
                    
                    Spacer()
                    
                    NavigationLink(destination: OrderConfirmationView(basket: basket, totalWeight: selectedFoodWeight, selectedDate: selectedDate), isActive: $showConfirmation) { EmptyView() }
                    Button("Confirm") {
                        self.showConfirmation = true
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.top, 40)
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
        ReviewOrder(basket: FoodBasket(business: BusinesssDetailsModel(id: "12345", bizName: "Business Name", uenNum: "12345", bizAdd: "My address", postalCode: "611138", monAvailable: true, tueAvailable: false, wedAvailable: true, thursAvailable: false, friAvailable: true, satAvailable: false, sunAvailable: true, typesOfItemsSold: ["Cereal"], startTime: Date(), endTime: Date()), foodItems: [FoodItem(id: "1234", name: "Royal Rice", type: "Groceries", quantity: 1, weight: "12000", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111")], expiryRange: "1 - 5 days", distToBusiness: "1.2"), selectedFoodItems: ["1234"], selectedDate: Date())
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
    var basket: FoodBasket
    var renderableItems: [FoodItem]
    var selectedFoodItems: Set = Set<String>()
    var totalWeight: String
    let calendar = Calendar.current
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack (alignment: .leading){
                HStack(alignment: .top){
                    Text("Selected Items")
                        .font(CustomFont.headerThree)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                    Spacer()
                    
                    // not the best solution for edit. will create many layers
                    NavigationLink("Edit", destination: BusinessFoodView(basket: basket, initialSelectedFoodItems: selectedFoodItems))
                        .foregroundColor(Color("action"))
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
                            Text("\(item.weight.isEmpty ? "No weight specified" : FormatHelper.getWeightInKilograms(weight: item.weight))kg • \(item.halal ? "Halal" : "Non-halal")")
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
                
                Text("Total: \(totalWeight)kg • \(renderableItems.count) \(renderableItems.count > 1 ? "items" : "item")")
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
    var basket: FoodBasket
    var selectedFoodItems: Set = Set<String>()
    var selectedDate: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack (alignment: .leading){
                HStack(alignment: .top) {
                    Text("Collection Date")
                        .font(CustomFont.headerThree)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                    
                    Spacer()
                    // not the best solution for edit. will create many layers
                    NavigationLink("Edit", destination: CollectionDateView(basket: basket, selectedFoodItems: selectedFoodItems))
                        .foregroundColor(Color("action"))
                }
                
                VStack(alignment: .leading) {
                    Text("\(formatCollectionDate(inputDate: selectedDate))")
                        .font(CustomFont.headerFour)
                        .foregroundColor(Color.black)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text(basket.business.startTime, style: .time)
                            .font(CustomFont.bodyRegular)
                            .foregroundColor(Color.black)
                        Text("-")
                            .font(CustomFont.bodyRegular)
                            .foregroundColor(Color.black)
                        Text(basket.business.endTime, style: .time)
                            .font(CustomFont.bodyRegular)
                            .foregroundColor(Color.black)
                    }
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
        totalWeight = totalWeight + ((item.weight as NSString).floatValue * Float(item.quantity) / 1000);
    }
    
    return String(totalWeight)
}

func formatCollectionDate (inputDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, d MMMM yyyy"
    return formatter.string(from: inputDate)
}

