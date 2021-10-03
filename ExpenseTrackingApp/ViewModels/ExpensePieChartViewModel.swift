//
//  ExpensePieChartViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 01/10/21.
//

import Foundation

class ExpensePieChartViewModel: ObservableObject {
    
    @Published var expenseList: [ExpenseItemViewModel]
    
    init() {
        self.expenseList = ExpenseManager.shared.expenseList
    }
    
    var total: Double {
        expenseList.reduce(0) { value, expense in
            value + expense.amount
        }
    }
    
    var pieChartData: Dictionary<String, Double> {
        expenseList.reduce(into: [:]) { (result: inout [String: Double], expense) in
            let type = expense.type.rawValue
            let amount = expense.amount

            result[type, default: 0] += amount
        }
    }
    
}
