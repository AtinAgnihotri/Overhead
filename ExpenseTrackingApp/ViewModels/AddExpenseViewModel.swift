//
//  AddExpenseViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 24/09/21.
//

import UIKit

class AddExpenseViewModel: ObservableObject {
    
    @Published var name: String
    @Published var amount: String
    @Published var type: ExpenseType
    let types = ExpenseType.allCases
    
    init() {
        name = ""
        amount = ""
        type = types[0]
    }
    
    func addExpense(to expenseListVM: ExpenseListViewModel, onFail: @escaping (String, String) -> Void, completion: @escaping () -> Void) {
        // Input Validations
        guard name != "" else {
            onFail("Empty Name", "The name cannot be empty")
            return
        }
        guard let amount = Double(amount) else {
//            showError(alertTitle: "Invalid Amount", alertMsg: "Please enter a valid amount")
            onFail("Invalid Amount", "Please enter a valid amount")
            return
        }
        
        expenseListVM.saveExpense(name: name, type: type.rawValue, amount: amount)
        completion()
    }
    
    
    
    
}
