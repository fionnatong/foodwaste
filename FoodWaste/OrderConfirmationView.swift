import SwiftUI

struct OrderConfirmationView: View {
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("Your food donation has been reserved!")
                    .font(CustomFont.headerOne)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                Text("by FairPrice Xtra (VivoCity)")
                    .font(CustomFont.bodyMedium)
                    .padding(.bottom, 32)
                
                Text("Instead of food waste, you just turned 10.5kg of food into meals for the needy!")
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
                            Text("FairPrice Xtra (Vivo City)")
                                .font(CustomFont.headerFour)
                            Text("#01-23, 1 HarbourFront Walk, Singapore 098585")
                                .font(CustomFont.headerFour)
                                .fixedSize(horizontal: false, vertical: true)
                                
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Distance from Organisation")
                                .font(CustomFont.bodyTwoRegular)
                            Text("0.80 km")
                                .font(CustomFont.headerFour)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Collection Time")
                                .font(CustomFont.bodyTwoRegular)
                            Text("Friday, 5 August 2021")
                                .font(CustomFont.headerFour)
                            Text("9:00am - 5:30pm")
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
                Button("Go to Food Baskets") {
                    print("hehe")
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(.horizontal, 16)
        }
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationView()
    }
}
