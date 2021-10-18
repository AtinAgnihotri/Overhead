//
//  CurrencySelectionCard.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import SwiftUI

struct CurrencySelectionCard: View {
    
    @Binding var currency: String
    
    var body: some View {
        Section(header: Text("Currency Selection")) {
            Picker("Currency", selection: $currency) {
                ForEach(Constants.Views.Settings.currencies, id: \.self) {
                    Text($0).foregroundColor(.blue)
                }
            }
        }.secondaryListBackground()
    }
}

struct CurrencySelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectionCard(currency: .constant("₹"))
    }
}
