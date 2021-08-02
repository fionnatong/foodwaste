//
//  CardButton.swift
//  FoodWaste
//
//  Created by See Yihui on 3/8/21.
//

import SwiftUI

struct CardButtonStyle: ButtonStyle {
//    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .background(Color.white
                            .shadow(color: Color("shadow"), radius: 12, x:0, y:4))
            .cornerRadius(16)
    }
}


struct CardButton_Previews: PreviewProvider {
    static var previews: some View {
//        Button(action: { print("clicked!")}) {
//            Image("icon")
//        }.buttonStyle(CardButtonStyle())
        
        VStack {
            Button("test button") {
                print("clicked!")
            }.buttonStyle(CardButtonStyle())
        }
    }
}
