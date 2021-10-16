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
        getCriticalConfirmationAlert(title: "Confirm Reset",
                                     message: "Are you sure you want to reset the settings?", action: settingsVM.resetSettings)
    }
    
    func showDeletionAlert() -> Alert {
//        Alert(title: Text("Confirm Deletion"),
//              message: Text("Are you sure you want to delete all the expenses?"),
//              primaryButton: .destructive(Text("Confirm"), action: settingsVM.clearAllExpenses),
//              secondaryButton: .cancel())
        getCriticalConfirmationAlert(title: "Confirm Deletion",
                                     message: "Are you sure you want to delete all the expenses?", action: clearAllExpenses)
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
        showingAlert = showingAlert
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
