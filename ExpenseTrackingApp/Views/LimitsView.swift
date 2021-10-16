//
//  LimitsView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 13/10/21.
//

import SwiftUI

struct LimitsView: View {
    typealias RefreshHandler = () -> Void
    @ObservedObject var limitsVM = LimitsViewModel()
    @State private var showingAlert = false
    var refreshSettings: RefreshHandler?
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
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                        if limitsVM.isEditingLimit {
                            TextField("Monthly Limit", text: $limitsVM.spendingLimit)
                                .frame(alignment: .trailing)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color(UIColor.tertiarySystemFill))
                        } else {
                            Text(limitsVM.monthlyLimit)
                                .frame(alignment: .trailing)
                        }
                        
                    }
                    
                    
                        
                }.secondaryListBackground()
                
                if limitsVM.hasLimitSet {
                    Section(header: Text("Reminders")) {
                        Toggle("Set Reminders?", isOn: $limitsVM.setReminder)
                        
                    }.secondaryListBackground()
                }
                
                if limitsVM.setReminder {
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
            .alert(isPresented: $showingAlert) {
                getConfirmAlert()
            }
            .navigationBarItems(trailing: HStack {
                Button(action: confirmReset) {
                    Text("Reset")
                        .foregroundColor(.red)
                }
            })
        }.navigationBarTitle("Limits")
    }
    
    func didPressEditButton() {
        limitsVM.isEditingLimit.toggle()
        refreshSettings?()
    }
    
    func getConfirmAlert() -> Alert {
        Alert(title: Text("Reset Limits?"),
              message: Text("Do you want to reset all the limits?"),
              primaryButton: .default(Text("Confirm"), action: limitsVM.resetLimit),
              secondaryButton: .cancel())
    }
    
    func confirmReset() {
        showingAlert = true
        refreshSettings?()
    }
    
}

struct LimitsView_Previews: PreviewProvider {
    static var previews: some View {
        LimitsView()
    }
}
