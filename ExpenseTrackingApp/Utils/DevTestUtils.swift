//
//  DevTestUtils.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import Foundation

class DevTestUtils {
    static let shared = DevTestUtils()
    
    private init() {
        
    }
    
    func getExpenseListVM() -> ExpenseListViewModel {
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = "Test Expense"
        expense.amount = 1.22
        expense.date = Date()
        expense.type = "Personal"
        let expenseVM = ExpenseItemViewModel(expenseItem: expense)
        let expenseListVM = ExpenseListViewModel.getInstance()
        expenseListVM.expenseList = [expenseVM]
        return expenseListVM
    }
}
