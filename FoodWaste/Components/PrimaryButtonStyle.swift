import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(isEnabled ? Color("primary") : .gray)
            .cornerRadius(100)
            .font(CustomFont.button)
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Button("Primary Button") {
            print("clicked")
        }.buttonStyle(PrimaryButtonStyle())
    }
}
