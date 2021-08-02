//
//  OnboardingComplete.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct OnboardingComplete: View {
    var body: some View {
        VStack{
            Text("Awesome!")
                .font(CustomFont.headerOne)
            Text("Your food donations have been launched into the Marketplace")
            Image("success")
            Text("Check your Donation Inventory to see the status of your food donations.")
            Text("We will notify you when an organisation has decided to adopt your food.")
        }
    }
}

struct OnboardingComplete_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingComplete()
    }
}
