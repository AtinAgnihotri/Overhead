//
//  ReminderCard.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 19/10/21.
//

import SwiftUI

struct ReminderCard: View {
    
    @ObservedObject var limitsVM: LimitsViewModel
    
    init(_ limitsVM: LimitsViewModel) {
        self.limitsVM = limitsVM
    }
    
    var body: some View {
        Section(header: Text("Current Reminders")) {
            Text(limitsVM.currentReminders)
            DayPicker(selectedDays: $limitsVM.selectedDays)
            DatePicker("Select Time", selection: $limitsVM.selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            HStack {
                Spacer()
                Button("Save") {
                    limitsVM.saveReminders()
                }
                Spacer()
            }
        }.secondaryListBackground()
    }
}
