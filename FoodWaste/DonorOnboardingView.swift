import SwiftUI

struct DonorOnboardingView: View {
    @State private var goToAddItem: Bool = false;
    var body: some View {
        Text("Welcome, my donor")
        NavigationLink(destination: AddFoodItem(), isActive: $goToAddItem) {
            EmptyView()
        }
        Button("Donate!") {
            self.goToAddItem = true
        }
    }
}

struct DonorOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        DonorOnboardingView()
    }
}
