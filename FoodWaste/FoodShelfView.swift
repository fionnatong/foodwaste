//
//  FoodShelfView.swift
//  FoodWaste
//
//  Created by fionna on 30/7/21.
//

import SwiftUI

struct FoodShelfView: View {
    @ObservedObject private var viewModel = FoodShelfViewModel()
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var goToAddItem = false;
    
    func submit() {
//        if (!name.isEmpty && !quantity.isEmpty) {
//            self.viewModel.addFoodItem(name: name, quantity: Int(quantity) ?? 0)
//            name = ""
//            quantity = ""
//        }
    }
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            VStack{
                Button(action: { print("clicked!") }) {
                    HStack{
                        Image("ic-add")
                        Text("Add a food item")
                    }
                }.buttonStyle(AddFoodButtonStyle())
                
                NavigationLink(destination: AddFoodItem(), isActive: $goToAddItem) {
                    EmptyView()
                }
                Button("Donate!") {
                    self.goToAddItem = true
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.top, 40)
            }
            .padding(.horizontal, 16)
            
            // TODO: use scrollview with a ForEach to loop through fooditems
            VStack {
//                List(viewModel.foodItems) { item in
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text(item.name).font(.title)
//                            Spacer()
//                            Text("\(item.quantity)").font(.subheadline)
//                        }
//                    }
//                }
//                .onAppear() {
//                    self.viewModel.getFoodItems()
//                }
//                .navigationTitle("Food Shelf")
//                .toolbar {
//                    ToolbarItem(placement: .bottomBar) {
//                        HStack {
//                            TextField("Name", text: $name)
//                                .frame(minWidth: 100)
//                            TextField("Quantity", text: $quantity)
//                                .frame(minWidth: 100)
//                            Spacer()
//                            Button(action: self.submit) {
//                                Text("+")
//                            }
//                        }
//                    }
//                }
            }
            
           
        }
    }
}

struct FoodShelfView_Previews: PreviewProvider {
    static var previews: some View {
        FoodShelfView()
    }
}
