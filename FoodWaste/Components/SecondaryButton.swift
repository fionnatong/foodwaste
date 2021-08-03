//
//  SecondaryButton.swift
//  FoodWaste
//
//  Created by See Yihui on 3/8/21.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .foregroundColor(Color("gray-two"))
            .background(Color.white
                            .shadow(color: Color("shadow"), radius: 12, x:0, y:4)
                            .opacity(0.5)
            )
            .overlay(
                configuration.isPressed ? RoundedRectangle(cornerRadius: 16)
                .stroke(Color("primary"), lineWidth: 5) : nil
            )
            .cornerRadius(16)
            .font(CustomFont.bodyRegular)
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: { print("clicked!") }) {
                HStack{
                    Image("ic-add")
                    Text("Add a food item")
                }
            }.buttonStyle(SecondaryButtonStyle())
        }.background(Color.black)
    }
}
