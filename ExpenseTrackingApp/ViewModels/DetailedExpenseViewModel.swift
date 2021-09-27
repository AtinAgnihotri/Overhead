//
//  DetailedExpenseViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/09/21.
//

import Foundation

class DetailedExpenseViewModel: ObservableObject {
    
    @Published var isEditing: Bool = false {
        didSet {
            amount = String(expenseVM.amount)
            type = expenseVM.type
            note = expenseVM.note
        }
    }
    @Published var expenseVM: ExpenseItemViewModel
    @Published var amount: String
    @Published var type: ExpenseType
    @Published var note: String
    
    var date: String {
        "\(formatDate: expenseVM.date)"
    }
    
    init(with expenseVM: ExpenseItemViewModel) {
        self.expenseVM = expenseVM
        self.amount = String(expenseVM.amount)
        self.type = expenseVM.type
        self.note = expenseVM.note
    }
    
    func saveChanges(onFail: (String, String) -> Void) {
        if let amount = Double(amount) {
            expenseVM.updateItem(name: expenseVM.name, type: type, amount: amount, note: note)
        } else {
            onFail("Invalid Amount", "Please enter a valid amount to continue")
        }
    }
    
}
