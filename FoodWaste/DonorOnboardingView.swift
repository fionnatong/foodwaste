import SwiftUI

struct DonorOnboardingView: View {
    @State private var goToAddItem: Bool = false
    
    @State private var bizName: String = ""
    @State private var monAvailable: Bool = false
    @State private var tueAvailable: Bool = false
    @State private var wedAvailable: Bool = false
    @State private var thursAvailable: Bool = false
    @State private var friAvailable: Bool = false
    @State private var satAvailable: Bool = false
    @State private var sunAvailable: Bool = false
    @State private var MondayAvailable: Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: nil) {
                Text("Tell me about your business").font(CustomFont.headerOne)
                Input(label: "Business Name", placeholder: "", text: $bizName).padding(.bottom, 32)
                
                Text("Available Collection Dates")
                    .font(CustomFont.bodyMedium)
                    .lineLimit(1)
                    .padding(.bottom, 8)
                Group {
                    Checkbox(title: "Monday", isChecked: monAvailable)
                    Checkbox(title: "Tuesday", isChecked: tueAvailable)
                    Checkbox(title: "Wednesday", isChecked: wedAvailable)
                    Checkbox(title: "Thursday", isChecked: thursAvailable)
                    Checkbox(title: "Friday", isChecked: friAvailable)
                    Checkbox(title: "Saturday", isChecked: satAvailable)
                    Checkbox(title: "Sunday", isChecked: sunAvailable)
                }
                .padding(.bottom, 12)
                .onTapGesture {
                    self.endTextEditing()
                }
                NavigationLink(destination: AddFoodItem(), isActive: $goToAddItem) {
                    EmptyView()
                }
                Button("Donate!") {
                    self.goToAddItem = true
                }
            }
            .padding(.init(top: 48, leading: 16, bottom: 16, trailing: 16))
            .background(Color("secondary"))
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
