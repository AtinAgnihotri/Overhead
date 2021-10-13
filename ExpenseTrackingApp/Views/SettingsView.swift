//
//  SettingsView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import SwiftUI

enum AlertType {
    case deleteAll
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
                    LimitsSelectionCard()
                    
                }
                ShadedButton(text: "Clear All", backgroundColor: .red, gradientColor: .red, action: clearAllExpenses)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            
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
    
    func confirmDeleteAll() {
        alertType = .deleteAll
        showingAlert = true
    }
    
    func showAlert() -> Alert {
        switch alertType {
            case .deleteAll: return showDeletionAlert()
        }
    }
    
    func showDeletionAlert() -> Alert {
        Alert(title: Text("Confirm Deletion"),
              message: Text("Are you sure you want to delete all the expenses?"),
              primaryButton: .destructive(Text("Confirm"), action: settingsVM.clearAllExpenses),
              secondaryButton: .cancel())
    }
    
    func clearAllExpenses() {
        settingsVM.clearAllExpenses()
        dismissView()
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
