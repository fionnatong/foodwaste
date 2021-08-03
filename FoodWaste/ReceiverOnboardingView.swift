import SwiftUI

struct ReceiverOnboardingView: View {
    @StateObject var viewModel: RecipientViewModel
    @State private var completeOnboarding: Bool = false
    
    init(recipient: Recipient? = nil) {
        _viewModel = StateObject(wrappedValue: RecipientViewModel(initialValue: recipient))
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 24) {
                Text("Tell me about your organisation").font(CustomFont.headerOne)
                Input(label: "Organisation Name",  placeholder: "Enter the name of your organisation", text: .init(
                    get: { [viewModel] in viewModel.recipient.organisationName },
                    set: { [viewModel] in viewModel.updateName($0) }
                ))
                Input(label: "UEN Number",  placeholder: "Enter your UEN number", text: .init(
                    get: { [viewModel] in viewModel.recipient.uenNumber },
                    set: { [viewModel] in viewModel.updateUEN($0) }
                ))
                Input(label: "Organisation Address",  placeholder: "Enter the organisation's address", text: .init(
                    get: { [viewModel] in viewModel.recipient.address },
                    set: { [viewModel] in viewModel.updateAddress($0) }
                ))
                
                VStack {
                    NavigationLink(destination: OnboardingComplete(userType: .recipient), isActive: $completeOnboarding) {
                        EmptyView()
                    }
                    Button("Donate!") {
                        self.completeOnboarding = true
                    }
                }
            }
        }
    }
}

struct ReceiverOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverOnboardingView()
    }
}
