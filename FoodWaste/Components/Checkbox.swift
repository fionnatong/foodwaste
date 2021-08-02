import SwiftUI

struct Checkbox: View {
    var title: String
    @State var isChecked: Bool = false
    
    func toggle() {
        isChecked = !isChecked
    }
    
    var body: some View {
        Button(action: toggle, label: {
            HStack(spacing: 0) {
                Image("ic-checkbox-\(isChecked ? "checked" : "unchecked")")
                    .padding(.init(top: 18, leading: 29, bottom: 18, trailing: 18))
                Text(title)
                    .font(CustomFont.bodyRegular)
                    .foregroundColor(Color("text"))
                Spacer()
            }
        })
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("primary"), lineWidth: isChecked ? 3 : 0)
        )
        .background(Color.white .cornerRadius(16) .shadow(color: Color("shadow"), radius: 12, x: 0, y: 4) )
        .padding(.bottom, 28)
        
        
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Checkbox(title: "Monday", isChecked: false)
            Checkbox(title: "Tuesday", isChecked: true)
        }
    }
}
