//
//  DayPicker.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 15/10/21.
//

import SwiftUI

struct DayPicker: View {
    
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
//    @State private var selectedDays = Set<String>() {
//        didSet {
//            print(selectedDays)
//        }
//    }
    @Binding var selectedDays: Set<String>
    
    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                Button(action: {
                    didClick(on: day)
                }, label: {
                    Text(day)
                        .padding(5)
                        .background(switchBackground(for: day))
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                })
                .buttonStyle(PlainButtonStyle())
            }
            .secondaryListBackground()
        }
        .secondaryListBackground()
    }
    
    func didClick(on day: String) {
        if hasSelected(day: day) {
            selectedDays.remove(day)
        } else {
            selectedDays.insert(day)
        }
    }
    
    func hasSelected(day: String) -> Bool {
        selectedDays.contains(day)
    }
    
    func switchBackground(for day: String) -> some View {
        hasSelected(day: day) ? Color.green.opacity(0.4) : Color.gray.opacity(0.2)
    }
    
}

struct DayPicker_Previews: PreviewProvider {
    @State static private var days = Set<String>()
    static var previews: some View {
        DayPicker(selectedDays: $days)
    }
}
