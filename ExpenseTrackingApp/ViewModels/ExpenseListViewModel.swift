//
//  ExpenseListViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 03/10/21.
//

import Foundation

class ExpenseListViewModel: ObservableObject {
    @Published var expenseList: [ExpenseItemViewModel]
    
    init() {
        self.expenseList = ExpenseManager.shared.expenseList
    }
    
    func deleteExpenses(at offsets: IndexSet) {
        ExpenseManager.shared.deleteExpenses(at: offsets)
    }
    
}
