//
//  AddFoodItem.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct AddFoodItem: View {
    @StateObject var viewModel: AddItemViewModel
    @State private var goToComplete: Bool = false
    @State private var date = Date()
    
    init(item: FoodItem? = nil) {
        _viewModel = StateObject(wrappedValue: AddItemViewModel(initialValue: item))
    }
   
    func addItem() {
        self.viewModel.addFoodItem(onCompleted: {(isSuccess) -> Void in
            if isSuccess {
                self.goToComplete = true
            }
        })
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Add food item").font(CustomFont.headerOne)
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
                    Checkbox(title: "Halal", isChecked: Binding<Bool>(
                        get: { return self.viewModel.foodItem.halal},
                        set: { p in self.viewModel.foodItem.halal = p}
                    ))
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
        .navigationTitle("")
        .navigationBarHidden(true)
        // @TODO: can style this part?
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddFoodItem_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodItem()
    }
}
