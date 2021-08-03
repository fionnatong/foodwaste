import SwiftUI

struct ItemCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: CustomColor.shadow, radius: 12, x: 0, y: 4)
        
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Royal Umbrella Thai Hom Mali Rice")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(CustomFont.headerFour)
                    
                    Spacer()
                    
                    Text("x 8")
                        .font(CustomFont.bodyMedium)
                        .foregroundColor(CustomColor.primary)
                }
                
                HStack {
                    Text("40kg • Halal")
                        .font(CustomFont.caption)
                    
                    Spacer()
                    
                    Text("Expires in 5 weeks")
                        .font(CustomFont.caption)
                        .padding(4)
                        .frame(alignment: .trailing)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(CustomColor.primary)
                        )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
        }
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard()
    }
}
