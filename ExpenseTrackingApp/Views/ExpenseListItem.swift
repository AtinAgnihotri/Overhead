//
//  ExpenseListItem.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI

struct ExpenseListItem: View {
    var currecySymbol: String = "$"
    var expenseItem: ExpenseItemViewModel
    
    init(_ expenseItem: ExpenseItemViewModel) {
        self.expenseItem = expenseItem
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(expenseItem.name)
                    .font(.headline)
                    .padding(.horizontal)
                Text(expenseItem.type)
                    .font(.subheadline)
                    .padding(.horizontal)
            }
            Spacer()
            Text("\(currecySymbol)\(expenseItem.amount, specifier: "%g")")
                .font(.title)
                .padding()
        }
    }
}

//struct ExpenseDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseListItem( ExpenseItem(name: "Test Expense", amount: 20, type: "Business"))
//    }
//}
