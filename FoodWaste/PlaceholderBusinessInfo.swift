//
//  PlaceholderBusinessInfo.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct PlaceholderBusinessInfo: View {
    @State private var goToAddItem = false;
    
    var body: some View {
        Text("This is the temp add business info page for navigation")
        NavigationLink(destination: AddFoodItem(), isActive: $goToAddItem) {
            EmptyView()
        }
        Button("Next") {
            self.goToAddItem = true
        }
    }
}

struct PlaceholderBusinessInfo_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderBusinessInfo()
    }
}
