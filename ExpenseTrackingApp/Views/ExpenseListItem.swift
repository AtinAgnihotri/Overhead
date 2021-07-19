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
//                    .padding(.horizontal)
//                    .foregroundColor(.primary)
                Text(expenseItem.type)
                    .font(.subheadline)
//                    .padding(.)
            }
            Spacer()
            Text("\(currecySymbol)\(expenseItem.amount, specifier: "%g")")
                .font(.title)
                .padding(.horizontal)
        }
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
