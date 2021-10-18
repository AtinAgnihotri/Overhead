//
//  SettingsView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import SwiftUI

enum AlertType {
    case deleteAll
    case resetSettings
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var settingsVM = SettingsViewModel()
    @State private var alertType: AlertType = .deleteAll
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showingAlert = false
    
    
    
    
    var body: some View {
        NavigationView {

            VStack {
                Form {
                    CurrencySelectionCard(currency: $settingsVM.currency)
                    LimitsSelectionCard(refreshSettings: forceRefresh)
                    
//                    Button("Reset Preferences") {
//                        PersistenceManager.shared.resetPreferences()
//                    }
                    
                    Section(header: Text("Others")) {
//                        CenteredFormButton(text: "Reset Settings", backgroundColor: .red, action: confirmResetSettings)
                        HStack {
                            Spacer()
                            Button("Reset Settings", action: confirmResetSettings)
                                .foregroundColor(.red)
                            Spacer()
                        }.secondaryListBackground()
                        HStack {
                            Spacer()
                            Button("Clear all expenses", action: confirmDeleteAllExpenses)
                                .foregroundColor(.red)
                            Spacer()
                        }.secondaryListBackground()
                    }
                    
                }
//                ShadedButton(text: "Clear All", backgroundColor: .red, gradientColor: .red, action: clearAllExpenses)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
            
            }.navigationBarTitle("Settings")
            .navigationBarItems(trailing: DoneNavBarButton(action: dismissView))
            .alert(isPresented: $showingAlert) {
               showAlert()
            }
        }
    }
    
    func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func confirmResetSettings() {
        alertType = .resetSettings
        showingAlert = true
    }
    
    func confirmDeleteAllExpenses() {
        alertType = .deleteAll
        showingAlert = true
    }
    
    func showAlert() -> Alert {
        switch alertType {
            case .deleteAll: return showDeletionAlert()
        case .resetSettings: return showResetAlert()
        }
    }
    
    func showResetAlert() -> Alert {
        getCriticalConfirmationAlert(title: Constants.Alerts.ResetSettings.title,
                                     message: Constants.Alerts.ResetSettings.message, action: settingsVM.resetSettings)
    }
    
    func showDeletionAlert() -> Alert {
        getCriticalConfirmationAlert(title: Constants.Alerts.DeleteAllExpenses.title,
                                     message: Constants.Alerts.DeleteAllExpenses.message, action: clearAllExpenses)
    }
    
    func getCriticalConfirmationAlert(title: String, message: String?, action: @escaping () -> Void) -> Alert {
        let messageText = message == nil ? nil : Text(message!)
        return Alert(title: Text(title),
              message: messageText,
              primaryButton: .destructive(Text("Confirm"), action: action),
              secondaryButton: .cancel())
    }
    
    func clearAllExpenses() {
        settingsVM.clearAllExpenses()
        dismissView()
    }
    
    func forceRefresh() {
        let showingAlert = self.showingAlert
        self.showingAlert = showingAlert
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
