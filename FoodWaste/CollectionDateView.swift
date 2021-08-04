import SwiftUI

struct CollectionDateView: View {
    var business: BusinesssDetailsModel
    var foodItems: [FoodItem]
    @State private var selectedDate = Date()
    @State private var goToReview: Bool = false
    
    // TODO: how to disable certain days?
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let endDate = Calendar.current.dateComponents([.year, .month, .day], from: Date(timeIntervalSinceNow: 604800)) // 1 week
        
        let startComponents = DateComponents(year: today.year, month: today.month, day: today.day)
        let endComponents = DateComponents(year: endDate.year, month: endDate.month, day: endDate.day)
        
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 18) {
                Text(business.bizName)
                    .font(CustomFont.headerOne)
                
                Text(business.bizAdd)
                    .font(CustomFont.bodyRegular)
                
                Text("Select Collection Date")
                    .font(CustomFont.headerThree)
                
                VStack(alignment: .leading, spacing: 24) {
                    DatePicker("Select Collection Date", selection: $selectedDate, in: dateRange, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(CustomColor.primary)
                        .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading) {
                        Text("Time")
                            .font(CustomFont.headerThree)
                            .foregroundColor(CustomColor.primary)
                            .padding(.horizontal, 16)
                        
                        HStack {
                            Text(business.startTime, style: .time)
                            Text("-")
                            Text(business.endTime, style: .time)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
                .background(Color.white)
                .cornerRadius(16)
                
                Spacer()
                
                NavigationLink(destination: ReviewOrder(business: business, selectedFoodItems: foodItems, selectedDate: selectedDate), isActive: $goToReview) { EmptyView () }
                Button("Review details") {
                    self.goToReview = true
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(.horizontal, 16)
            // TODO: custom back button text?
        }
    }
}

struct CollectionDateView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDateView(business: BusinesssDetailsModel(id: "12345", bizName: "Business Name", uenNum: "12345", bizAdd: "My address", postalCode: "611138", monAvailable: true, tueAvailable: false, wedAvailable: true, thursAvailable: false, friAvailable: true, satAvailable: false, sunAvailable: true, typesOfItemsSold: ["Cereal"], startTime: Date(), endTime: Date()), foodItems: [FoodItem(id: "1234", name: "Royal Rice", type: "Groceries", quantity: 1, weight: "12kg", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111")])
    }
}
