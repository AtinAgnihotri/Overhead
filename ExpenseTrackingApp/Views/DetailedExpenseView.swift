//
//  DetailedExpenseView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 28/06/21.
//

import SwiftUI

struct DetailedExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var expense: CDExpenseItem
    
    var expenseVM: ExpenseItemViewModel {
        ExpenseItemViewModel(expenseItem: expense)
    }
    
    var formattedDate: String {
        "Date: \(formatDate: expenseVM.date)"
    }
    
    init(_ expenseItem: CDExpenseItem?) {
        guard let expenseItem = expenseItem else {
            self.expense = CDExpenseItem()
            presentationMode.wrappedValue.dismiss()
            return
        }
        self.expense = expenseItem
    }
    
    var body: some View {
        NavigationView {
            Form {
                Text("Amount: \(expenseVM.amount, specifier: "%g")")
                    .padding()
                Text("Type: \(expenseVM.type)")
                    .padding()
                Text(formattedDate)
                    .padding()
            }.navigationBarTitle(expenseVM.name)
        }.tertiaryBackground()
    }
    
    func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct DetailedExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = "Test Expense"
        expense.amount = 1.22
        expense.date = Date()
        expense.type = "Personal"
        return DetailedExpenseView(expense)
    }
}
