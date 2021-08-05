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
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    
                    Text("x \(item.quantity)")
                        .font(CustomFont.bodyMedium)
                        .foregroundColor(CustomColor.primary)
                }
                .padding(.trailing, 8)
                
                HStack {
                    Text("\(item.weight.isEmpty ? "No weight specified" : FormatHelper.getWeightInKilograms(weight: item.weight))kg • \(item.halal ? "Halal" : "Non-halal")")
                        .font(CustomFont.caption)
                        .foregroundColor(Color("gray-two"))
                }
                
                HStack {
                    Spacer()
                    Text("Expires in \(calendar.dateComponents([.day], from: Date(), to: item.expiry).day!) days")
                        .font(CustomFont.caption)
                        .padding(4)
                        .frame(alignment: .trailing)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(CustomColor.primary)
                        )
                }
                .padding(.top, 24)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 8))
        }
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ItemCard(item: FoodItem(id: "1234", name: "Royal Rice", type: "Groceries", quantity: 1, weight: "120", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111"))
        }
    }
}
