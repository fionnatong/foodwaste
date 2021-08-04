import SwiftUI

struct FoodBasketsView: View {
    @ObservedObject private var basketViewModel = FoodBasketsViewModel()
    @State private var recipientAddress = UserDefaults.standard.string(forKey: "RecipientAddress")
    @State private var businessPostalCode: String = "608536" // TODO: remove hardcode later
    @State private var enableButton: Bool = false;
    
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
                    
                    ForEach(self.basketViewModel.foodBaskets) { basket in
                        NavigationLink(destination: BusinessFoodView(business: basket.business, foodItems: basket.foodItems)) {
                            BusinessCard(basket: basket)
                        }
                    }
                }
                .onAppear() {
                    self.basketViewModel.getBusinessInfo(onComplete: nil)
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
