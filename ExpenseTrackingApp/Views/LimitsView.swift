//
//  LimitsView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 13/10/21.
//

import SwiftUI

struct LimitsView: View {
    @ObservedObject var limitsVM = LimitsViewModel()
    var editButtonText: String {
        limitsVM.isEditingLimit ? "Done" : "Edit"
    }
    
    var editButtonColor: Color {
        limitsVM.isEditingLimit ? .blue : .red
    }
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Monthly Limit")) {
                    HStack {
                        Button(action: didPressEditButton) {
                            Text(editButtonText)
                                .foregroundColor(editButtonColor)
                        }
                        Spacer()
                        if limitsVM.isEditingLimit {
                            TextField("Monthly Limit", text: $limitsVM.spendingLimit)
                                .frame(alignment: .trailing)
                                .keyboardType(.decimalPad)
                        } else {
                            Text(limitsVM.monthlyLimit)
                                .frame(alignment: .trailing)
                        }
//                        DatePicker("", selection: $limitsVM.pickedDate, displayedComponents:  )
                        
                    }
                }.secondaryListBackground()
                
                if limitsVM.hasLimitSet {
                    Section(header: Text("Reminders")) {
                        Toggle("Set Reminder?", isOn: $limitsVM.setReminder)
                            .secondaryListBackground()
                    }
                    if limitsVM.setReminder {
                        Section {
                            DayPicker()
                            
                            DatePicker("Select Time", selection: $limitsVM.pickedDate, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle())
                                .secondaryListBackground()
                            
                            HStack {
                                Spacer()
                                Button("Save") {
                                    print("Save coming soon")
                                }
                                Spacer()
                            }.secondaryListBackground()
                        }
                    }
                }
            }.navigationBarItems(trailing: HStack {
                Button(action: limitsVM.resetLimit) {
                    Text("Reset")
                        .foregroundColor(.red)
                }
            })
        }.navigationBarTitle("Limits")
    }
    

    
    func didPressEditButton() {
        limitsVM.isEditingLimit.toggle()
    }
    
    func didSelectDay(_ day: String) {
        
    }
    
}

struct LimitsView_Previews: PreviewProvider {
    static var previews: some View {
        LimitsView()
    }
}
