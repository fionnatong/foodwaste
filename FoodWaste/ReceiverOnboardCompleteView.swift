import SwiftUI

struct ReceiverOnboardCompleteView: View {
    @State private var completeOnboarding: Bool = false;
    
    var body: some View {
        ZStack(alignment: .top) {
            CustomColor.secondary.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 8) {
                Text("Welcome onboard")
                    .font(CustomFont.headerOne)
                
                Text("We're so glad to have you join us in our mission to reduce food waste in Singapore.")
                    .font(CustomFont.bodyRegular)
                    .multilineTextAlignment(.center)
                
                Image("success")
                
                Text("Begin the mission by viewing and adopting the latest food donations in the Food baskets.")
                    .font(CustomFont.bodyRegular)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack {
                    NavigationLink(destination: FoodBasketsView(), isActive: $completeOnboarding) {
                        EmptyView()
                    }
                    Button("Go to Food baskets") {
                        UserDefaults.standard.set(true, forKey: "IsOnboarded")
                        self.completeOnboarding = true
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 24)
            .navigationBarHidden(true)
        }
    }
}

struct ReceiverOnboardComplete_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverOnboardCompleteView()
    }
}
