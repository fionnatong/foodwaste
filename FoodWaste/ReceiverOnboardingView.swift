import SwiftUI

struct ReceiverOnboardingView: View {
    var body: some View {
        VStack (spacing: 8) {
            Text("I want some donuts")
            Text("Onboarding form here")
            NavigationLink(destination: ReceiverOnboardCompleteView()) {
                Text("Complete onboarding")
            }
        }
    }
}

struct ReceiverOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverOnboardingView()
    }
}
