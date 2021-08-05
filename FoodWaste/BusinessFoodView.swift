import SwiftUI

struct BusinessFoodView: View {
    var basket: FoodBasket
    var initialSelectedFoodItems: Set<String>?
    @State private var selectedFoodItems: Set = Set<String>()
    @State private var enableButton: Bool = false;
    @State private var showCollectionTime: Bool = false
    
    func toggle(itemId: String) {
        if selectedFoodItems.contains(itemId) {
            selectedFoodItems.remove(itemId)
        } else {
            selectedFoodItems.insert(itemId)
        }
        
        if !selectedFoodItems.isEmpty {
            enableButton = true
        } else {
            enableButton = false
        }
    }
    
    func initSelectedItems() {
        selectedFoodItems = initialSelectedFoodItems ?? []
    }
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(basket.business.bizName)
                        .font(CustomFont.headerOne)
                    Spacer()
                    Text("filter here")
                }
                
                Text(basket.business.bizAdd)
                    .font(CustomFont.bodyRegular)
                
                // TODO: add distance by calculating coordinates
                Text("\(basket.foodItems.count) groceries • \(basket.distToBusiness) km")
                    .font(CustomFont.bodyRegular)
                
                ScrollView {
                    ForEach(basket.foodItems) { item in
                        Button(action: { toggle(itemId: item.id!) }) {
                            ItemCard(item: item)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(CustomColor.primary, lineWidth: selectedFoodItems.contains(item.id!) ? 3 : 0))
                    }
                }
                .onAppear {
                    initSelectedItems()
                }
                
                NavigationLink(destination: CollectionDateView(basket: basket, selectedFoodItems: selectedFoodItems), isActive: $showCollectionTime) { EmptyView () }
                Button("Next: Select collection time") {
                    self.showCollectionTime = true
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(!enableButton)
            }
            .padding(.horizontal, 16)
        }
    }
}

struct BusinessFoodView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessFoodView(basket: FoodBasket(business: BusinesssDetailsModel(id: "12345", bizName: "Business Name", uenNum: "12345", bizAdd: "My address", postalCode: "611138", monAvailable: true, tueAvailable: false, wedAvailable: true, thursAvailable: false, friAvailable: true, satAvailable: false, sunAvailable: true, typesOfItemsSold: ["Cereal"], startTime: Date(), endTime: Date()), foodItems: [FoodItem(id: "1234", name: "Royal Rice", type: "Groceries", quantity: 1, weight: "1000", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111")], expiryRange: "1 - 5 days", distToBusiness: "1.2"))
    }
}
