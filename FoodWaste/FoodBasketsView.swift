import SwiftUI

struct FoodBasketsView: View {
    @ObservedObject private var basketViewModel = FoodBasketsViewModel()
    @State private var recipientAddress = UserDefaults.standard.string(forKey: "RecipientAddress")
    @State private var enableButton: Bool = false;
    private var numOfItems: Int {
        basketViewModel.foodBaskets.reduce(0) { result, foodBasket in
            result + foodBasket.foodItems.count
        }
    }
    
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: nil) {
                Text("Food baskets")
                    .font(CustomFont.headerOne)
                    .padding(.bottom, 24)
                Text("Showing \(numOfItems) food types near you")
                    .font(CustomFont.bodyRegular)
                    .padding(.bottom, 24)
                
                ForEach(self.basketViewModel.foodBaskets) { basket in
                    NavigationLink(destination: BusinessFoodView(basket: basket)) {
                        BusinessCard(basket: basket)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.init(top: 68, leading: 16, bottom: 16, trailing: 16))
            .background(CustomColor.secondary)
        }
        .onAppear() {
            self.basketViewModel.getBusinessInfo(onComplete: nil)
        }
        .background(CustomColor.secondary)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct FoodBasketsView_Previews: PreviewProvider {
    static var previews: some View {
        FoodBasketsView()
    }
}
