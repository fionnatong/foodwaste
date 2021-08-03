import SwiftUI

struct DonorOnboardingView: View {
    @State private var goToOnboardSuccess: Bool = false
    @State private var viewModel = BusinessDetailsViewModel()
   
    var FoodItems = ["Beverages (Sealed)", "Canned food", "Rice & grains", "Cereal"]
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: nil) {
                Group {
                    Text("Tell me about your business").font(CustomFont.headerOne)
                    Input(label: "Business Name", placeholder: "", text: $viewModel.businessDetails.bizName)
                    Input(label: "UEN Number", placeholder: "", text: $viewModel.businessDetails.uenNum)
                    Input(label: "Business Address", placeholder: "", text: $viewModel.businessDetails.bizAdd)
                    Input(label: "Postal Code", placeholder: "", text: $viewModel.businessDetails.postalCode)
                    CheckboxGrid(groupLabel: "Types of Food & Drinks Sold",
                                 titleList: FoodItems,
                                 selectedSet: $viewModel.businessDetails.typesOfItemsSold).onTapGesture {
                        self.endTextEditing()
                    }
                }
                .padding(.bottom, 32)
                Text("Available Collection Dates")
                    .font(CustomFont.bodyTwoRegular)
                    .lineLimit(1)
                    .padding(.bottom, 8)
                Group {
                    Checkbox(title: "Monday", isChecked: $viewModel.businessDetails.monAvailable)
                    Checkbox(title: "Tuesday", isChecked: $viewModel.businessDetails.tueAvailable)
                    Checkbox(title: "Wednesday", isChecked: $viewModel.businessDetails.wedAvailable)
                    Checkbox(title: "Thursday", isChecked: $viewModel.businessDetails.thursAvailable)
                    Checkbox(title: "Friday", isChecked: $viewModel.businessDetails.friAvailable
                    )
                    Checkbox(title: "Saturday", isChecked: $viewModel.businessDetails.satAvailable)
                    Checkbox(title: "Sunday", isChecked: $viewModel.businessDetails.sunAvailable)
                }
                .padding(.bottom, 12)
                .onTapGesture {
                    self.endTextEditing()
                }
                Group {
                    Text("Available Collection Dates")
                        .font(CustomFont.bodyTwoRegular)
                        .lineLimit(1)
                        .padding(.bottom, 8)
                    HStack(alignment: .center, spacing: 16) {
                        DatePicker("", selection: $viewModel.businessDetails.startTime, displayedComponents: .hourAndMinute)
                            .background(Color.white)
                            .accentColor(Color("text"))
                            .labelsHidden()
                        Text("to")
                        DatePicker("", selection: $viewModel.businessDetails.endTime, displayedComponents: .hourAndMinute)
                            .background(Color.white)
                            .accentColor(Color("text"))
                            .labelsHidden()
                        Spacer()
                    }
                }
                Text("You can edit these information later in your Profile.").font(CustomFont.bodyRegular).padding(.bottom, 36)
                Group {
                    NavigationLink(destination: OnboardingComplete(), isActive: $goToOnboardSuccess) {
                        EmptyView()
                    }
                    Button("Next") {
                        viewModel.saveToFirebase { completed in
                            // TODO: handle when completed = false
                            self.goToOnboardSuccess = true
                        }
                    }.buttonStyle(PrimaryButtonStyle())
                }.padding(.bottom, 32)
                
            }
            .padding(.init(top: 48, leading: 16, bottom: 16, trailing: 16))
            .background(CustomColor.secondary)
            .onTapGesture {
                self.endTextEditing()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

struct DonorOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        DonorOnboardingView()
    }
}

extension View {
    func endTextEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
