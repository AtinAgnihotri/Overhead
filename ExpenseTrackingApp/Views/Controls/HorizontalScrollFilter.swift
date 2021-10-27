//
//  SwiftUIView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/10/21.
//

import SwiftUI

struct HorizontalScrollFilter: View {
    
    @Binding var selection: String
    var options: [String]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Spacer()
                ForEach(options, id: \.self) { option in
                    
                    Button(action: {
                        didClick(on: option)
                    }, label: {
                        Text(option)
                            .padding(3)
                            .background(switchBackground(for: option))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
            .frame(alignment: .center)
        }
        .frame(alignment: .center)
    }
    
    func didClick(on option: String) {
        if hasSelected(option) {
//            selectedDays.remove(day)
        } else {
//            selectedDays.insert(day)
        }
    }
    
    func hasSelected(_ option: String) -> Bool {
//        selectedDays.contains(day)
         option == selection
//        true
    }
    
    func switchBackground(for option: String) -> some View {
        hasSelected(option) ? Color.green.opacity(0.4) : Color.gray.opacity(0.2)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollFilter(selection: .constant("1D"), options: Constants.Views.PieChart.filters)
    }
}
