//
//  LimitsView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 13/10/21.
//

import SwiftUI

enum LimitAlerts {
    case confirmReset
    case nothingToReset
}

struct LimitsView: View {
    @ObservedObject var limitsVM = LimitsViewModel()
    @State private var showingAlert = false
    @State private var alertType: LimitAlerts = .confirmReset
    var refreshSettings: Constants.Types.RefreshHandler?
    
    var body: some View {
        VStack {
            Form {
                LimitCard(limitsVM, refreshSettings: refreshSettings)
                
                if limitsVM.hasLimitSet {
                    Section(header: Text("Reminders")) {
                        Toggle("Set Reminders?", isOn: $limitsVM.setReminder)
                    }.secondaryListBackground()
                }
                
                if limitsVM.setReminder {
                    ReminderCard(limitsVM)
                }
            }
            .alert(isPresented: $showingAlert) {
                switch alertType {
                    case .confirmReset: return getConfirmAlert()
                    case .nothingToReset: return getInfoAlert()
                }
                
            }
            .navigationBarItems(trailing: HStack {
                Button(action: confirmReset) {
                    Text("Reset")
                        .foregroundColor(.red)
                }
            })
        }.navigationBarTitle("Limits")
    }
    
    private func getInfoAlert() -> Alert {
        Alert(title: Text(Constants.Alerts.ResetLimit.failedResetTitle), message: nil, dismissButton: .default(Text("OK")))
    }
    
    private func getConfirmAlert() -> Alert {
        Alert(title: Text(Constants.Alerts.ResetLimit.title),
              message: Text(Constants.Alerts.ResetLimit.message),
              primaryButton: .destructive(Text("Confirm"), action: limitsVM.resetLimit),
              secondaryButton: .cancel())
    }
    
    private func confirmReset() {
        alertType = limitsVM.hasLimitSet ? .confirmReset : .nothingToReset
        showingAlert = true
        refreshSettings?()
    }
    
}

struct LimitsView_Previews: PreviewProvider {
    static var previews: some View {
        LimitsView()
    }
}
