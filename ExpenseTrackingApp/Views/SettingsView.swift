//
//  SettingsView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var settingsVM = SettingsViewModel()
    
    private var currencies = ["د.إ", "$", "৳", "R$", "ب.د", "₣", "¥", "₡", "kr", "€", "ლ", "₵", "D", "L", "Kn", "G", "Rp", "₪", "₹", "Sh", "₩", "د.ك", "Rs"]
    
    var body: some View {
        NavigationView {
            VStack {
//            List {
//                Picker("Currency:", selection: $settingsVM.currency) {
//                    ForEach(currencies, id:\.self) { currency in
//                        HStack {
//                            Text("currency")
//                            Spacer()
//                            Text(currency)
//                        }.padding()
//                    }
//                }.padding()
//                .pickerStyle(MenuPickerStyle())
//                .secondaryListBackground()
                Form {
                    CurrencySelectionCard(currency: $settingsVM.currency)
                }
            }.navigationBarTitle("Settings")
            .navigationBarItems(trailing: DoneNavBarButton(action: dismissView))
        }
    }
    
    func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
