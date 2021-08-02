//
//  ContentView.swift
//  FoodWaste
//
//  Created by fionna on 28/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int? = nil
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    NavigationLink(destination: DonorOnboardingView(), tag: 0, selection: $selection,  label: {EmptyView()})
                    Button("I am donor") {
                        self.selection = 0
                    }.buttonStyle(PrimaryButtonStyle()).padding(.bottom, 24)
                    NavigationLink(destination: ReceiverOnboardingView(), tag: 1, selection: $selection,  label: {EmptyView()})
                    Button("I am receiver") {
                        self.selection = 1
                    }.buttonStyle(PrimaryButtonStyle())
                }.navigationTitle("Choose your role")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
