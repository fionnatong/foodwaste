//
//  AddFoodItem.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct AddFoodItem: View {
    @State private var foodName: String = ""
    @State private var foodQuantity: String = ""
    @State private var itemWeight: String = ""
    @State private var goToComplete: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color("secondary").edgesIgnoringSafeArea(.all)
            VStack {
                // TODO: how to align this to the start of parent?
                VStack(alignment: .leading){
                    Text("Add a food donation")
                        .font(CustomFont.headerOne)
                }
                
                VStack(alignment: .leading) {
                    Input(label: "Food Name",  placeholder: "Enter the name of the food", text: $foodName)
                    Input(label: "Quantity",  placeholder: "Enter the quantity of the food", text: $foodQuantity)
                    Input(label: "Weight per item",  placeholder: "Enter the weight of the food", text: $itemWeight)
                    // TODO: add expiry date datepicker
                    // TODO: add halal checkbox
                    // TODO: add add item button
                }
                .padding(.horizontal, 14)
                .padding(.top, 10)
                
                NavigationLink(destination: OnboardingComplete(), isActive: $goToComplete) {
                    EmptyView()
                }
                Button("Donate!") {
                    self.goToComplete = true
                }
            }
        }
    }
}

struct AddFoodItem_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodItem()
    }
}
