import SwiftUI

struct CollectionDateView: View {
    var business: BusinesssDetailsModel
    var foodItems: [FoodItem]
    var selectedFoodItems: Set = Set<String>()
    @State private var collectionRange = Date()...
    @State private var selectedDate = Date()
    @State private var goToReview: Bool = false
    @State private var showDateNotAvailableAlert = false
    
    var availableDaysStr: String {
        var days: [String] = []
        business.dayAvailabilites.forEach { (key: String, value: Bool) in
            if(value) {
                days.append(key)
            }
        }
        var formattedDaysStr = ""
        days.forEach { day in
            formattedDaysStr += "\(day), "
        }
        return String(String(formattedDaysStr.dropLast()).dropLast())
    }
    
    var body: some View {
        ZStack {
            CustomColor.secondary.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 18) {
                Text(business.bizName)
                    .font(CustomFont.headerOne)
                
                Text(business.bizAdd)
                    .font(CustomFont.bodyRegular)
                VStack(alignment: .leading) {
                    Text("Select Collection Date")
                        .font(CustomFont.headerThree)
                    Text("* Donor is only available on \(availableDaysStr)")
                        .font(CustomFont.caption)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    DatePicker("Select Collection Date", selection: $selectedDate, in: collectionRange, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(CustomColor.primary)
                        .padding(.horizontal, 16)
                        .onChange(of: selectedDate, perform: { newSelectedDate in
                            if (!business.foodCanBeCollected(on: newSelectedDate)) {
                                showDateNotAvailableAlert = true
                            }
                        })
                        .onAppear(perform: {
                            selectedDate = business.nextAvailableDateFoodCanBeCollected(from: Date())
                            collectionRange = selectedDate...
                        })
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
                
                NavigationLink(destination: ReviewOrder(business: business, foodItems: foodItems, selectedFoodItems: selectedFoodItems, selectedDate: selectedDate), isActive: $goToReview) { EmptyView () }
                Button("Review details") {
                    self.goToReview = true
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding(.horizontal, 16)
            // TODO: custom back button text?
        }
        .alert(isPresented: $showDateNotAvailableAlert, content: {
            return Alert(title: Text("Donor is only free on \(availableDaysStr)"),
                         message: Text("The next available date will be selected for you"),
                         dismissButton: .default(Text("Got it"), action: {
                            selectedDate = business.nextAvailableDateFoodCanBeCollected(from: selectedDate)
                         }))
        })
    }
}

struct CollectionDateView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionDateView(business: BusinesssDetailsModel(id: "12345", bizName: "Business Name", uenNum: "12345", bizAdd: "My address", postalCode: "611138", monAvailable: true, tueAvailable: false, wedAvailable: true, thursAvailable: false, friAvailable: true, satAvailable: false, sunAvailable: true, typesOfItemsSold: ["Cereal"], startTime: Date(), endTime: Date()), foodItems: [FoodItem(id: "1234", name: "Royal Rice", type: "Groceries", quantity: 1, weight: "12kg", halal: false, expiry: Date(timeIntervalSinceNow: 864000), bizUen: "112233E", postalCode: "650111")], selectedFoodItems: ["1234"])
    }
}
