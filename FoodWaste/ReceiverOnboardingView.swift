import SwiftUI

struct ReceiverOnboardingView: View {
    @StateObject var viewModel: RecipientViewModel
    @State private var completeOnboarding: Bool = false
    
    init(recipient: Recipient? = nil) {
        _viewModel = StateObject(wrappedValue: RecipientViewModel(initialValue: recipient))
    }
    
    func addRecipient() {
        // @TODO: call the firebase function
        // store recipient to app storage
        UserDefaults.standard.set(viewModel.recipient.address, forKey: "RecipientAddress")
    }
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
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
                    
                    Input(label: "Postal code",  placeholder: "Enter the organisation's address postal code", text: .constant("188675"))
                    
                    VStack {
                        NavigationLink(destination: ReceiverOnboardCompleteView(), isActive: $completeOnboarding) {
                            EmptyView()
                        }
                        Button("Next") {
                            self.addRecipient()
                            self.completeOnboarding = true
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .padding(.top, 40)
                    }
                }
                .padding(.init(top: 0, leading: 16, bottom: 16, trailing: 16))
                .onTapGesture {
                    self.endTextEditing()
                }
            }
            .navigationBarHidden(true)
        }
       
    }
}

struct ReceiverOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiverOnboardingView()
    }
}
