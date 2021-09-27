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
    @Published var note: String
    let types = ExpenseType.allCases
    
    init() {
        name = ""
        amount = ""
        type = types[0]
        note = ""
    }
    
    func addExpense(completion: @escaping () -> Void, onFail: @escaping (String, String) -> Void) {
        // Input Validations
        guard name != "" else {
            onFail("Empty Name", "The name cannot be empty")
            return
        }
        guard let amount = Double(amount) else {
            onFail("Invalid Amount", "Please enter a valid amount")
            return
        }
        ExpenseListViewModel.getInstance().saveExpense(name: name, type: type.rawValue, amount: amount, note: note)
        completion()
    }
    
    
    
    
}
