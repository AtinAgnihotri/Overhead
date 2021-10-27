//
//  ExpensePieChartViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 01/10/21.
//

import Foundation

class ExpensePieChartViewModel: ObservableObject {
    
    enum ChartFilter: String{
        case day = "Today"
        case week = "Week"
        case month = "Month"
        case quarter = "Quarter"
        case year = "Year"
    }
    
    @Published var expenseList: [ExpenseItemViewModel]
    @Published var chartFilter: String {
        didSet {
            currentChartFilter = ChartFilter(rawValue: chartFilter)
        }
    }
    
    private var currentChartFilter: ChartFilter? = nil
    
    init() {
        self.expenseList = ExpenseManager.shared.expenseList
        chartFilter = ""
    }
    
    var total: Double {
        
        let total = expenseList.reduce(0) { value, expense in
            value + (isExpenseInFilteredRange(expense) ? expense.amount : 0)
        }
        print("ValChange calc total: \(total)")
        return total
    }
    
    var pieChartData: Dictionary<String, Double> {
        print("ValChange calc chart data")
        return expenseList.reduce(into: [:]) { (result: inout [String: Double], expense) in
            let type = expense.type.rawValue
            let amount = expense.amount
            if isExpenseInFilteredRange(expense) {
                result[type, default: 0] += amount
            }
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
    
    func isExpenseInFilteredRange(_ expense: ExpenseItemViewModel) -> Bool {
        if let filter = currentChartFilter {
            let components: Set<Calendar.Component> = [.day, .weekOfYear, .month, .quarter, .year]
            let expenseComponent = Calendar.current.dateComponents(components, from: expense.date)
            let filteredComponent = Calendar.current.dateComponents(components, from: Date())
            let dayCheck = expenseComponent.day == filteredComponent.day
            let weekCheck = expenseComponent.weekOfYear == filteredComponent.weekOfYear
            let monthCheck = expenseComponent.month == filteredComponent.month
            let quarterCheck = expenseComponent.quarter == filteredComponent.quarter
            let yearCheck = expenseComponent.year == expenseComponent.year
            switch filter {
            case .day:
                return dayCheck && monthCheck && yearCheck
            case .week:
                return weekCheck && yearCheck
            case .month:
                return monthCheck && yearCheck
            case .quarter:
                return quarterCheck && yearCheck
            case .year:
                return yearCheck
            }
        } else {
            return true
        }
    }
    
}
