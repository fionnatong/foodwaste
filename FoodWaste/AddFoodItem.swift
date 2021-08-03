//
//  AddFoodItem.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct AddFoodItem: View {
    @StateObject var viewModel = AddItemViewModel()
    @State private var goToComplete: Bool = false
    
    func addItem() {
        self.viewModel.addFoodItem()
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading) {
                    Input(label: "Food Name",  placeholder: "Enter the name of the food", text: .init(
                        get: { [viewModel] in viewModel.foodItem.name },
                        set: { [viewModel] in viewModel.updateName($0) }
                    ))
                    Input(label: "Quantity",  placeholder: "Enter the quantity of the food", text: .init(
                        get: { [viewModel] in viewModel.foodItem.quantity == 0 ? "" : String(viewModel.foodItem.quantity) },
                        set: { [viewModel] in viewModel.updateQuantity($0) }
                    ))
                    Input(label: "Weight per item",  placeholder: "Enter the weight of the food", text: .init(
                        get: { [viewModel] in viewModel.foodItem.weight },
                        set: { [viewModel] in viewModel.updateWeight($0) }
                    ))
                    // TODO: add expiry date datepicker
                    // TODO: add halal checkbox
                    // TODO: add add item button
                    
                    VStack {
                        NavigationLink(destination: OnboardingComplete(), isActive: $goToComplete) {
                            EmptyView()
                        }
                        Button("Add item") {
                            self.addItem()
                        }.buttonStyle(PrimaryButtonStyle())
                    }
                    .padding(.top, 30)
                    
                }
                .padding(.horizontal, 14)
                .padding(.top, 10)
            }
        }
        .navigationTitle("Add a food donation")
    }
}

struct AddFoodItem_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodItem()
    }
}
