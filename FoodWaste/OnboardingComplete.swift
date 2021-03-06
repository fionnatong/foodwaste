//
//  OnboardingComplete.swift
//  FoodWaste
//
//  Created by See Yihui on 2/8/21.
//

import SwiftUI

struct OnboardingComplete: View {
    @State private var completeOnboarding: Bool = false;
    @EnvironmentObject var bizDetailsviewModel: BusinessDetailsViewModel

    var body: some View {
        ZStack(alignment: .top){
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            Spacer().padding(.top, 24)
            VStack{
                VStack(spacing: 8) {
                    Text("Awesome!")
                        .font(CustomFont.headerOne)
                    Text("Your food donations have been launched into the Marketplace.")
                        .font(CustomFont.bodyRegular)
                        .multilineTextAlignment(.center)
                        // need to add fixedSize for linewrap to work properly
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 24)
               
                Image("success")
                
                VStack{
                    Text("Check your Donation Inventory to see the status of your food donations.")
                        .font(CustomFont.bodyRegular)
                        .multilineTextAlignment(.center)
                    Text("We will notify you when an organisation has decided to adopt your food.")
                        .font(CustomFont.bodyRegular)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                VStack{
                    NavigationLink(destination: FoodShelfView(), isActive: $completeOnboarding) {
                        EmptyView()
                    }
                    Button("Go to Food Inventory") {
                        UserDefaults.standard.set(true, forKey: "IsOnboarded")
                        UserDefaults.standard.setValue(bizDetailsviewModel.businessDetails.uenNum, forKey: "OnboardedBizUen")
                        UserDefaults.standard.setValue(bizDetailsviewModel.businessDetails.postalCode, forKey: "OnboardedBizPostalCode")
                        self.completeOnboarding = true
                    }.buttonStyle(PrimaryButtonStyle())
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
            .navigationBarHidden(true)
        }
    }
}

struct OnboardingComplete_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingComplete()
    }
}
