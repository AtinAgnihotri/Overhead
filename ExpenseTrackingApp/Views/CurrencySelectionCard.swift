//
//  CurrencySelectionCard.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import SwiftUI

struct CurrencySelectionCard: View {
    
    @Binding var currency: String
    var currencies = ["د.إ", "$", "৳", "R$", "ب.د", "₣", "¥", "₡", "kr", "€", "ლ", "₵", "D", "L", "Kn", "G", "Rp", "₪", "₹", "Sh", "₩", "د.ك", "Rs"]
    
//    init(currency: )
    
    var body: some View {
        Section(header: Text("Currency Selection")) {
//            HStack {
//                Text("Currency Selected:")
//                Spacer()
//                Text(currency)
//            }.padding()
//            .font(.headline)
            Picker("Currency", selection: $currency) {
                ForEach(currencies, id: \.self) {
                    Text($0).foregroundColor(.blue)
                }
            }
//            Section(header: Text("Currency Selection")) {
//                Picker("Currency", selection: $currency) {
//                    ForEach(currencies, id: \.self) {
//                        Text($0)
//                    }
//                }
//                Text("Hello")
//            }
        }.secondaryListBackground()
    }
}

struct CurrencySelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectionCard(currency: .constant("₹"))
    }
}
