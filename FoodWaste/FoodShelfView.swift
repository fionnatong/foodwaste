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
    
    var body: some View {
        NavigationView {
            ZStack{
                CustomColor.secondary.edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack (spacing: 16){
                        NavigationLink(destination: AddFoodItem(), isActive: $goToAddItem) {
                            EmptyView()
                        }
                        Button(action: { self.goToAddItem = true }) {
                            HStack{
                                Image("ic-add")
                                Text("Add a food item")
                            }
                        }.buttonStyle(AddFoodButtonStyle())
                        
                        
                        VStack {
                            ForEach(self.viewModel.foodItems) { foodItem in
                                NavigationLink(destination: AddFoodItem(item: foodItem)) {
                                    ItemCard(item: foodItem)
                                }
                                
                            }
                        }.onAppear() {
                            self.viewModel.getFoodItems()
                        }
                            
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
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct FoodShelfView_Previews: PreviewProvider {
    static var previews: some View {
        FoodShelfView()
    }
}
