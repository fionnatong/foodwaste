import SwiftUI

struct Checkbox: View {
    var title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: { self.isChecked.toggle() }, label: {
            HStack(spacing: 0) {
                Image("ic-checkbox-\(isChecked ? "checked" : "unchecked")")
                    .padding(.init(top: 18, leading: 29, bottom: 18, trailing: 18))
                Text(title)
                    .font(CustomFont.bodyRegular)
                Spacer()
            }
        })
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("primary"), lineWidth: isChecked ? 3 : 0)
                
        )
        .foregroundColor(Color("text"))
        .background(Color.white .cornerRadius(16) .shadow(color: Color("shadow"), radius: 12, x: 0, y: 4) )
    }
}

struct Checkbox_Previews: PreviewProvider {
    @State private var checkboxFalse: Bool = false
    @State private var checkboxTrue: Bool = true
    static var previews: some View {
        VStack {
            Checkbox(title: "Monday", isChecked: .constant(false)).padding(.bottom, 20)
            Checkbox(title: "Tuesday", isChecked: .constant(true))
        }
    }
}
