//
//  BusinessCard.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI
import CoreLocation

struct BusinessCard: View {
    var basket: FoodBasket
    let calendar = Calendar.current
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: CustomColor.shadow, radius: 12, x: 0, y: 4)
        
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(basket.business.bizName)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(CustomFont.headerFour)
                        .foregroundColor(Color.black)
                    Spacer()
                }
                .padding(.trailing, 8)
                
                HStack {
                    Text("\(basket.foodItems.count) food items • \(basket.distToBusiness) km")
                        .font(CustomFont.caption)
                        .foregroundColor(Color("gray-two"))
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text("Expires in \(basket.expiryRange)")
                        .font(CustomFont.caption)
                        .padding(4)
                        .frame(alignment: .trailing)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(CustomColor.primary)
                        )
                }
                .padding(.top, 24)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 8))
        }
    }
}


struct BusinessCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BusinessCard(basket: FoodBasket(business: BusinesssDetailsModel(bizName: "Company 1"), foodItems: [FoodItem(id: "1234", name: "Royal Rice", type: "Groceries",quantity: 1, weight: "12kg", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111")], expiryRange: "10 - 15 days", distToBusiness: "0.80"))
        }
    }
}
