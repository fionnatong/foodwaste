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
        NavigationView {
            ZStack(alignment: .topLeading){
                Color("secondary").edgesIgnoringSafeArea(.all)
                VStack {
                    Image("icon")
                    Text("Welcome!")
                        .font(CustomFont.headerOne)
                    Text("I would like to:")
                        .font(CustomFont.headerTwo)
                        .padding(.top, 70)
                        .padding(.bottom, 24)
                    NavigationLink(destination: DonorOnboardingView(), tag: 0, selection: $selection,  label: {EmptyView()})
                    Button("I am donor") {
                        self.selection = 0
                    }.buttonStyle(PrimaryButtonStyle()).padding(.bottom, 24)
                    NavigationLink(destination: ReceiverOnboardingView(), tag: 1, selection: $selection,  label: {EmptyView()})
                    Button("I am receiver") {
                        self.selection = 1
                    }.buttonStyle(PrimaryButtonStyle())
                }
                .padding(.top, 100)
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
