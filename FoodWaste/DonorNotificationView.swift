import SwiftUI

// TODO: use actual values instead of hardcoded ones
struct DonorNotificationView: View {
    @State private var goFoodInventory: Bool = false
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    Text("Your food is adopted!")
                        .font(CustomFont.headerOne)
                        .padding(.bottom, 8)
                    
                    Text("By FoodBank Singapore")
                        .font(CustomFont.headerFour)
                        .padding(.bottom, 32)
                    
                    Text("Instead of food waste, you just turned 10.5kg of food into meals for the needy!")
                        .font(CustomFont.bodyRegular)
                    
                    Image("success")
                    
                    VStack(spacing: 24) {
                        Text("Collection Details")
                            .font(CustomFont.headerThree)
                            .foregroundColor(CustomColor.primary)
                            .padding(.top, 16)
                        
                        Text("A representative from (Org Name) will be coming to pick up your donation on")
                            .font(CustomFont.bodyRegular)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text("Wednesday, 28 July 2021 3:00PM")
                            .font(CustomFont.headerTwo)
                            .padding(.bottom, 16)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.bottom, 40)
                    
                    NavigationLink(destination: FoodShelfView(), isActive: $goFoodInventory) { EmptyView () }
                    Button("Go to Food Inventory") {
                        goFoodInventory = true
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            .padding(.horizontal, 16)
            .navigationBarHidden(true)
        }
    }
}

struct DonorNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        DonorNotificationView()
    }
}
