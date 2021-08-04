//
//  ContentView.swift
//  FoodWaste
//
//  Created by fionna on 28/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnboarded = UserDefaults.standard.bool(forKey: "IsOnboarded")
    
    func resetOnboarded() {
        UserDefaults.standard.set(false, forKey: "IsOnboarded")
    }

    @ViewBuilder
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading){
                CustomColor.secondary.edgesIgnoringSafeArea(.all)
                VStack {
                    Image("icon")
                    Text("Welcome!")
                        .font(CustomFont.headerOne)
                    Text("I would like to:")
                        .font(CustomFont.headerTwo)
                        .padding(.top, 70)
                        .padding(.bottom, 24)
                    
                    if isOnboarded {
                        NavigationLink("Skip to inventory", destination: FoodShelfView())
                        NavigationLink("Skip to basket", destination: FoodBasketsView())
                        Button("Reset onboarded value") {
                            resetOnboarded()
                            isOnboarded = false
                        }
                    } else {
                        NewUserView()
                    }
                }
                .padding(.top, 100)
                .padding(.horizontal, 14)
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


struct NewUserView: View {
    @State private var selection: Int? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            VStack{
                NavigationLink(destination: DonorOnboardingView(), tag: 0, selection: $selection,  label: {EmptyView()})
                Button(action: {self.selection = 0}) {
                    VStack{
                        Image("landing-donor")
                        Text("Donate Food")
                            .font(CustomFont.headerFour)
                        Text("As a business owner")
                            .font(CustomFont.bodyTwoRegular)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 16)
                }
                .buttonStyle(CardButtonStyle())
            }
            
            VStack {
                NavigationLink(destination: ReceiverOnboardingView(), tag: 1, selection: $selection,  label: {EmptyView()})
                Button(action: {self.selection = 1}) {
                    VStack{
                        Image("landing-receiver")
                        Text("Receive Food")
                            .font(CustomFont.headerFour)
                        Text("As an organisation")
                            .font(CustomFont.bodyTwoRegular)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 16)
                }
                .buttonStyle(CardButtonStyle())
            }
        }
    }
}
