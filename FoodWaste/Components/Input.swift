//
//  Input.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct Input: View {
    var label: String
    var placeholder: String
    var text: Binding<String>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(CustomFont.bodyMedium)
                .lineLimit(1)
            TextField(placeholder, text: text)
                .padding(EdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24))
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color("shadow"), radius: 12, x: 0, y: 4)
        }
    }
}

struct Input_Previews: PreviewProvider {
    static var previews: some View {
        // Input preview is a bit wonky. to fix later
        VStack{
            Text("Why won't preview load?")
        }
//        Input(label: "Food name", placeholder: "Enter name of food", text: .constant("Tests"))
    }
}
