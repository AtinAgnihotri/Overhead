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
    
    var isLimitExceeded: Bool {
        if let limit = SettingsManager.shared.monthyLimit {
            if limit != 0 && limit < monthyTotal {
                return true
            }
        }
        return false
    }
    
    var monthyTotal: Double {
        let currentMonth = Calendar.current.dateComponents([.month], from: Date()).month
        let monthlyExpenses: [ExpenseItemViewModel] = expenseList.compactMap { expense in
            let expenseMonth = Calendar.current.dateComponents([.month], from: expense.date).month
            return currentMonth == expenseMonth ? expense : nil
        }
        return monthlyExpenses.reduce(0) { $0 + $1.amount }
    }
    
}
