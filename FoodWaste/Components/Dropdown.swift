//
//  Dropdown.swift
//  FoodWaste
//
//  Created by See Yihui on 4/8/21.
//

import SwiftUI

struct Dropdown: View {
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil
    private let rowHeight: CGFloat = 62
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    
    var body: some View {
        Button(action: {
            self.shouldShowDropdown.toggle()
        }) {
            HStack {
                Text(selectedOption == nil ? options[0].value : selectedOption!.value)
                    .font(CustomFont.bodyRegular)
                    .foregroundColor(Color.black)

                Spacer()

                Image(systemName: self.shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 15, height: 10)
                    .foregroundColor(Color("action"))
            }
        }
        .padding(.init(top: 20, leading: 24, bottom: 20, trailing: 24))
        .background(Color.white.cornerRadius(16)
                        .shadow(color: Color("shadow"), radius: 12, x:0, y:4))
        .overlay(
            VStack {
                if self.shouldShowDropdown {
                    Spacer(minLength: rowHeight) // hardcoded for now. not sure how to get lineheight
                    DropdownList(options: self.options, onOptionSelected: { option in
                        shouldShowDropdown = false
                        selectedOption = option
                        self.onOptionSelected?(option)
                    }, rowHeight: rowHeight)
                }
            }, alignment: .topLeading
        )
    }
}

struct DropdownList: View {
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    var rowHeight: CGFloat

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                }
            }
        }
        .frame(height: options.count > 1 ? rowHeight * 2 : rowHeight)
        .padding(.vertical, 5)
        .background(Color.white)
        .cornerRadius(16)
    }
}

struct DropdownRow: View {
    var option: DropdownOption
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?
    
    var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack {
                Text("\(option.value)")
                    .padding(.init(top: 20, leading: 24, bottom: 20, trailing: 24))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
    }
}

struct DropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}

struct Dropdown_Previews: PreviewProvider {
    static var uniqueKey: String {
            UUID().uuidString
        }

    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: "Sunday"),
        DropdownOption(key: uniqueKey, value: "Monday"),
        DropdownOption(key: uniqueKey, value: "Tuesday"),
        DropdownOption(key: uniqueKey, value: "Wednesday"),
        DropdownOption(key: uniqueKey, value: "Thursday"),
        DropdownOption(key: uniqueKey, value: "Friday"),
        DropdownOption(key: uniqueKey, value: "Saturday")
    ]
    
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Dropdown(options: options, onOptionSelected: { option in
                        print(option)})
        }
    }
}
