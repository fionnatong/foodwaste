import SwiftUI

struct CheckboxGrid: View {
    var groupLabel: String
    var titleList: [String]
    @State var selectedSet: Set = Set<String>()
    
    func toggle(itemName: String) {
        if (selectedSet.contains(itemName)) {
            selectedSet.remove(itemName)
        } else {
            selectedSet.insert(itemName)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(groupLabel)
                .font(CustomFont.bodyTwoRegular)
                .padding(.bottom, 8)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
                ForEach(titleList, id: \.self) { item in
                    Button(action: { toggle(itemName: item) }, label: {
                        VStack {
                            Spacer()
                            Text(item)
                                .font(CustomFont.bodyRegular)
                                .padding(.bottom, 8)
                            
                        }.frame(maxWidth: .infinity, minHeight: 118, idealHeight: 118)
                    })
                    
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("primary"), lineWidth: selectedSet.contains(item) ? 3 : 0))
                    .foregroundColor(Color("text"))
                    .background(Color.white .cornerRadius(16) .shadow(color: Color("shadow"), radius: 12, x: 0, y: 4) )
                }
            }
        }
    }
}


struct CheckboxGrid_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxGrid(groupLabel: " This is a grid", titleList: ["Beverages (Sealed)", "Canned food", "Rice & grains", "Cereal"])
    }
}
