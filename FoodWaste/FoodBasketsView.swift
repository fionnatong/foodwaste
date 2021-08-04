import SwiftUI

struct FoodBasketsView: View {
    @ObservedObject private var viewModel = FoodShelfViewModel()
    @ObservedObject private var basketViewModel = FoodBasketsViewModel()
    @State private var recipientAddress = UserDefaults.standard.string(forKey: "RecipientAddress")
//    @State private var selectedFoodItems: Set = Set<String>()
    @State private var businessPostalCode: String = "608536" // TODO: remove hardcode later
    @State private var enableButton: Bool = false;
    
//    func toggle(itemId: String) {
//        if (selectedFoodItems.contains(itemId)) {
//            selectedFoodItems.remove(itemId)
//        } else {
//            selectedFoodItems.insert(itemId)
//        }
//
//        if !selectedFoodItems.isEmpty {
//            enableButton = true
//        }
//    }
    
    var body: some View {
//        Text("TODO: FOOD BASKETS LIST")
        // get user object to display address (done)
        // get business info (put to dummy postal code for now)
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
                    
//                    ForEach(self.viewModel.foodItems) { foodItem in
//                        Button(action: { toggle(itemId: foodItem.id!) }) {
//                            ItemCard(item: foodItem)
//                        }
//                        .overlay(RoundedRectangle(cornerRadius: 16)
//                                    .stroke(Color("primary"), lineWidth: selectedFoodItems.contains(foodItem.id!) ? 3 : 0)
//                        )
//                    }
                    
                    ForEach(self.basketViewModel.foodBaskets) { basket in
                        Button(action: { print("clicked!")}) {
                            BusinessCard(basket: basket)
                        }
                    }
                }
                .onAppear() {
                    self.viewModel.getFoodItems()
                    self.basketViewModel.getBusinessInfo()
                }
                .padding(.horizontal, 16)
            }
            VStack {
                Spacer()
                //@TODO: add back when view is added
//                    NavigationLink(destination: FoodBasketsView(), isActive: $selectTime) {
//                        EmptyView()
//                    }
                Button("Next: Select collection time") {
                    print("clicked")
                }
                .buttonStyle(PrimaryButtonStyle()).disabled(!enableButton)
            }
            .padding(.horizontal, 16)
        }
        .navigationBarHidden(true)
    }
}

struct FoodBasketsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodBasketsView()
    }
}
