//
//  AddFoodItem.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct AddFoodItem: View {
    @State private var foodName: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color("secondary").edgesIgnoringSafeArea(.all)
            VStack {
                VStack(){
                    Text("Add a food donation")
                        .font(CustomFont.headerOne)
                }
                .padding(.horizontal, 14)
                
                VStack(alignment: .leading) {
                    Input(label: "Food Name",  placeholder: "Enter the name of the food", text: $foodName)
                }
                .padding(.horizontal, 14)
                .padding(.top, 10)
            }
        }
    }
}

struct AddFoodItem_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodItem()
    }
}
