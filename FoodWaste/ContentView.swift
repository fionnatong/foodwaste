//
//  ContentView.swift
//  FoodWaste
//
//  Created by fionna on 28/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.secondary
                VStack {
                    Text("Hello, world!")
                        .padding()
                    
                    NavigationLink(destination: FoodShelfView()) {
                        Text("Go to Food Shelf")
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
