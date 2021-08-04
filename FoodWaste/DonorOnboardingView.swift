import SwiftUI

struct DonorOnboardingView: View {
    @State private var goToOnboardSuccess: Bool = false
    @StateObject var bizDetailsviewModel = BusinessDetailsViewModel()
    
    var FoodItems = ["Beverages (Sealed)", "Canned food", "Rice & grains", "Cereal"]
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: nil) {
                Group {
                    Text("Tell me about your business").font(CustomFont.headerOne)
                    Input(label: "Business Name", placeholder: "", text: $bizDetailsviewModel.businessDetails.bizName)
                    Input(label: "UEN Number", placeholder: "", text: $bizDetailsviewModel.businessDetails.uenNum)
                    Input(label: "Business Address", placeholder: "", text: $bizDetailsviewModel.businessDetails.bizAdd)
                    Input(label: "Postal Code", placeholder: "", text: $bizDetailsviewModel.businessDetails.postalCode)
                    CheckboxGrid(groupLabel: "Types of Food & Drinks Sold",
                                 titleList: FoodItems,
                                 selectedSet: $bizDetailsviewModel.businessDetails.typesOfItemsSold).onTapGesture {
                                    self.endTextEditing()
                                 }
                }
                .padding(.bottom, 32)
                Text("Available Collection Dates")
                    .font(CustomFont.bodyTwoRegular)
                    .lineLimit(1)
                    .padding(.bottom, 8)
                Group {
                    Checkbox(title: "Monday", isChecked: $bizDetailsviewModel.businessDetails.monAvailable)
                    Checkbox(title: "Tuesday", isChecked: $bizDetailsviewModel.businessDetails.tueAvailable)
                    Checkbox(title: "Wednesday", isChecked: $bizDetailsviewModel.businessDetails.wedAvailable)
                    Checkbox(title: "Thursday", isChecked: $bizDetailsviewModel.businessDetails.thursAvailable)
                    Checkbox(title: "Friday", isChecked: $bizDetailsviewModel.businessDetails.friAvailable
                    )
                    Checkbox(title: "Saturday", isChecked: $bizDetailsviewModel.businessDetails.satAvailable)
                    Checkbox(title: "Sunday", isChecked: $bizDetailsviewModel.businessDetails.sunAvailable)
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
                        DatePicker("", selection: $bizDetailsviewModel.businessDetails.startTime, displayedComponents: .hourAndMinute)
                            .background(Color.white)
                            .accentColor(Color("text"))
                            .labelsHidden()
                        Text("to")
                        DatePicker("", selection: $bizDetailsviewModel.businessDetails.endTime, displayedComponents: .hourAndMinute)
                            .background(Color.white)
                            .accentColor(Color("text"))
                            .labelsHidden()
                        Spacer()
                    }
                }
                Text("You can edit these information later in your Profile.").font(CustomFont.bodyRegular).padding(.bottom, 36)
                Group {
                    NavigationLink(destination: OnboardingComplete().environmentObject(bizDetailsviewModel)
                                   , isActive: $goToOnboardSuccess) {
                        EmptyView()
                    }
                    Button("Next") {
                        bizDetailsviewModel.saveToFirebase { completed in
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
