import SwiftUI

struct OrderConfirmationView: View {
    var basket: FoodBasket
    var totalWeight: String
    var selectedDate: Date
    
    @State private var returnToList: Bool = false
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("Your food donation has been reserved!")
                    .font(CustomFont.headerOne)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                Text("by \(basket.business.bizName)")
                    .font(CustomFont.bodyMedium)
                    .padding(.bottom, 32)
                
                Text("Instead of food waste, you just turned \(totalWeight)kg of food into meals for the needy!")
                    .font(CustomFont.bodyRegular)
                    .multilineTextAlignment(.center)
                
                Image("success")
                
                VStack(spacing: 24) {
                    Text("Collection Details")
                        .font(CustomFont.headerThree)
                        .foregroundColor(CustomColor.primary)
                        .padding(.top, 16)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Address")
                                .font(CustomFont.bodyTwoRegular)
                            Text("\(basket.business.bizName)")
                                .font(CustomFont.headerFour)
                            Text("\(basket.business.bizAdd)")
                                .font(CustomFont.headerFour)
                                .fixedSize(horizontal: false, vertical: true)
                                
                        }
//                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Distance from Organisation")
                                .font(CustomFont.bodyTwoRegular)
                            Text("\(basket.distToBusiness) km")
                                .font(CustomFont.headerFour)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Collection Time")
                                .font(CustomFont.bodyTwoRegular)
                            Text("\(formatCollectionDate(inputDate: selectedDate))")
                                .font(CustomFont.headerFour)
                            Text("\(formatOperatingHours(startTime: basket.business.startTime, endTime: basket.business.endTime))")
                                .font(CustomFont.headerFour)
                        }
                        .padding(.bottom, 16)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.bottom, 16)
                
                Text("The collection details has been sent to your email inbox.")
                    .font(CustomFont.headerFour)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                
                // TODO: pop back to root navigation
                NavigationLink(destination: FoodBasketsView(), isActive: $returnToList) {EmptyView()}
                    .foregroundColor(Color("action"))
                Button("Go to Food Baskets") {
                    self.returnToList = true
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 16)
        }
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationView(basket: FoodBasket(business: BusinesssDetailsModel(id: "12345", bizName: "Business Name", uenNum: "12345", bizAdd: "My address", postalCode: "611138", monAvailable: true, tueAvailable: false, wedAvailable: true, thursAvailable: false, friAvailable: true, satAvailable: false, sunAvailable: true, typesOfItemsSold: ["Cereal"], startTime: Date(), endTime: Date()), foodItems: [FoodItem(id: "1234", name: "Royal Rice", type: "Groceries", quantity: 1, weight: "12kg", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111")], expiryRange: "1 - 5 days", distToBusiness: "1.2"), totalWeight: "12", selectedDate: Date())
    }
}
