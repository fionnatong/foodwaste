//
//  CardButton.swift
//  FoodWaste
//
//  Created by See Yihui on 3/8/21.
//

import SwiftUI

struct CardButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(maxWidth: .infinity)
            .background(Color.white
                            .shadow(color: Color("shadow"), radius: 12, x:0, y:4))
            .overlay(
                configuration.isPressed ? RoundedRectangle(cornerRadius: 16)
                .stroke(Color("primary"), lineWidth: 5) : nil
            )
            .cornerRadius(16)
            
    }
}


struct CardButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button("test button") {
                print("clicked!")
            }.buttonStyle(CardButtonStyle())
        }
    }
}
