//
//  FilterModal.swift
//  FoodWaste
//
//  Created by See Yihui on 5/8/21.
//

import SwiftUI

struct FilterModal: View {
    var toggleLabel: String
    var filters: [FilterSet]
    @State private var showingSheet = false

    var body: some View {
        Button("\(toggleLabel)") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            FilterModalBody(filters: filters)
        }
    }
}

struct FilterModal_Previews: PreviewProvider {
    static var previews: some View {
        FilterModal(toggleLabel: "Filter", filters: [FilterSet(title: "Food Type", options: ["Beverages", "Confectionery"])])
    }
}

struct FilterModalBody: View {
    var filters: [FilterSet]
    @Environment(\.presentationMode) var presentationMode
 
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Filter")
                        .font(CustomFont.headerTwo)
                    Spacer()
                    Button(action: { presentationMode.wrappedValue.dismiss() } ) {
                        Image("ic-close")
                    }
                }
                
                VStack {
                    ForEach(filters, id: \.self) { filter in
                        Text("\(filter.title)")
                            .font(CustomFont.headerFour)
                            .padding(.bottom, 12)
                        ForEach(filter.options, id: \.self) { option in
                            Checkbox(title: "\(option)", isChecked: .constant(true))
                                .padding(.bottom, 8)
                        }
                        
                    }
                }
            }
            .padding(16)
        }
    }
}

struct FilterSet: Hashable {
    let title: String
    let options: [String]
}
