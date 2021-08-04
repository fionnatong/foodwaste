import SwiftUI

struct ReceiverOnboardingView: View {
    @StateObject var viewModel: RecipientViewModel
    @State private var completeOnboarding: Bool = false
    
    init(recipient: Recipient? = nil) {
        _viewModel = StateObject(wrappedValue: RecipientViewModel(initialValue: recipient))
    }
    
    func addRecipient() {
        UserDefaults.standard.set(viewModel.recipient.address, forKey: "RecipientAddress")
        viewModel.addRecipient(onCompleted: {(isSuccess) -> Void in
            if isSuccess {
                self.completeOnboarding = true
            }
        })
    }
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (alignment: .leading, spacing: 32) {
                    Text("Tell me about your organisation").font(CustomFont.headerOne)
                        .padding(.bottom, 8)
                    Input(label: "Organisation Name",  placeholder: "Enter the name of your organisation", text: $viewModel.recipient.organisationName)
                    Input(label: "UEN Number",  placeholder: "Enter your UEN number", text: $viewModel.recipient.uenNumber)
                    Input(label: "Organisation Address",  placeholder: "Enter the organisation's address", text: $viewModel.recipient.address)
                    Input(label: "Postal code",  placeholder: "Enter the organisation's postal code", text: $viewModel.recipient.postalCode)
                   
                    VStack {
                        NavigationLink(destination: ReceiverOnboardCompleteView(), isActive: $completeOnboarding) {
                            EmptyView()
                        }
                        Button("Next") {
                            self.addRecipient()
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
