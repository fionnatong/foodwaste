import SwiftUI

struct ItemCard: View {
    var item: FoodItem
    let calendar = Calendar.current
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: CustomColor.shadow, radius: 12, x: 0, y: 4)
        
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(item.name)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(CustomFont.headerFour)
                    
                    Spacer()
                    
                    Text("x \(item.quantity)")
                        .font(CustomFont.bodyMedium)
                        .foregroundColor(CustomColor.primary)
                }
                
                HStack {
                    Text("\(item.weight) • \(item.halal ? "Halal" : "Non-halal")")
                        .font(CustomFont.caption)
                    
                    Spacer()
                    
                    Text("Expires in \(calendar.dateComponents([.day], from: item.expiry).day!) days")
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
        ItemCard(item: FoodItem(id: "1234", name: "Royal Rice", quantity: 1, weight: "12kg", halal: false, expiry: Date(timeIntervalSinceNow: -86400)))
    }
}
