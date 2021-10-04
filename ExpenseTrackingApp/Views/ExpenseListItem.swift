//
//  ExpenseListItem.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI

struct ExpenseListItem: View {
    var currecySymbol: String = SettingsManager.shared.currency
    var expenseItem: ExpenseItemViewModel
    
    init(_ expenseItem: ExpenseItemViewModel) {
        self.expenseItem = expenseItem
    }
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(expenseItem.name)
                    .font(.headline)
                Text(expenseItem.type.rawValue)
                    .font(.subheadline)
            }
            Spacer()
            Text("\(currecySymbol)\(expenseItem.amount, specifier: "%g")")
                .font(.title)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ExpenseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = "Test Expense"
        expense.amount = 1.23
        expense.date = Date()
        expense.type = "Personal"
        return ExpenseListItem(ExpenseItemViewModel(expenseItem: expense))
    }
}
