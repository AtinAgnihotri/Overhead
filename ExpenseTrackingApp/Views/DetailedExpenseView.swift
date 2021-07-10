//
//  DetailedExpenseView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 28/06/21.
//

import SwiftUI

struct DetailedExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var expense: ExpenseItemViewModel
    var formattedDate: String {
        "Date: \(formatDate: expense.date)"
    }
    
    init(_ expenseItem: CDExpenseItem?) {
        guard let expenseItem = expenseItem else {
            self.expense = ExpenseItemViewModel(expenseItem: CDExpenseItem())
            presentationMode.wrappedValue.dismiss()
            return
        }
        self.expense = ExpenseItemViewModel(expenseItem: expenseItem)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Text("Amount: \(expense.amount, specifier: "%g")")
                    .padding()
                Text("Type: \(expense.type)")
                    .padding()
                Text(formattedDate)
                    .padding()
            }.navigationBarTitle(expense.name)
        }
    }
    
    func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

//struct DetailedExpenseView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedExpenseView(ExpenseItem(name: "Expense name", amount: 20, type: "Personal"))
//    }
//}
