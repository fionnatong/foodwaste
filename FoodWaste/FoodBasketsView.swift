import SwiftUI

struct FoodBasketsView: View {
    @ObservedObject private var viewModel = FoodShelfViewModel()
    @State private var recipientAddress = UserDefaults.standard.string(forKey: "RecipientAddress")
    @State private var selectedFoodItems: Set = Set<String>()
    
    func toggle(itemId: String) {
        if (selectedFoodItems.contains(itemId)) {
            selectedFoodItems.remove(itemId)
        } else {
            selectedFoodItems.insert(itemId)
        }
    }
    
    var body: some View {
//        Text("TODO: FOOD BASKETS LIST")
        // get user object to display address
        // sort by expiry
        ZStack{
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            ScrollView{
                VStack(alignment: .leading) {
                    Text("Food baskets")
                        .font(CustomFont.headerOne)
                    Text("Showing 10 food types near you")
                        .font(CustomFont.bodyRegular)
                    Text("\(recipientAddress ?? "")")
                        .font(CustomFont.headerFour)
                    Text("10 groceries • 0.80km")
                        .font(CustomFont.bodyTwoRegular)
                        .foregroundColor(Color("gray-two"))
                    
                    ForEach(self.viewModel.foodItems) { foodItem in
                        Button(action: { toggle(itemId: foodItem.id!) }) {
                            ItemCard(item: foodItem)
                        }
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("primary"), lineWidth: selectedFoodItems.contains(foodItem.id!) ? 3 : 0)
                        )
                    }
                    
                    //@TODO: add back when view is added
//                    NavigationLink(destination: FoodBasketsView(), isActive: $selectTime) {
//                        EmptyView()
//                    }
                    // @TODO how do I set button to disabled?
                    // how to set to floating button
                    Button("Next: Select collection time") {
                        print("clicked")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .onAppear() {
                    self.viewModel.getFoodItems()
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationBarHidden(true)
    }
}

struct FoodBasketsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodBasketsView()
    }
}
