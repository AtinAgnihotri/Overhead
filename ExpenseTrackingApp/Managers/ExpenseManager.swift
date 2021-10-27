//
//  ExpenseManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation
import CoreData
import SwiftUI
import NotificationCenter

class ExpenseManager: ObservableObject {
    
    enum ChartFilter: String{
        case day = "Today"
        case week = "Week"
        case month = "Month"
        case quarter = "Quarter"
        case year = "Year"
    }
    
    static public let shared = ExpenseManager()
    
    private let persistenceController = PersistenceManager.shared
    private weak var settingsManager = SettingsManager.shared
    
    @Published var expenseList = [ExpenseItemViewModel]()
    @Published var chartFilter: String {
        didSet {
            currentChartFilter = ChartFilter(rawValue: chartFilter)
            getAllExpenses()
        }
    }
    
    private var currentChartFilter: ChartFilter? = nil
    
    var total: Double {
        expenseList.reduce(0) { value, expense in
            value + expense.amount
        }
    }
    
    var isLimitExceeded : Bool {
        if let limit = settingsManager?.monthyLimit,
           limit != 0,
           limit < total {
            return true
        }
        return false
    }
    
    private init() {
        // Get items from DataModel on startup
        chartFilter = ""
        getAllExpenses()
        setupRemoteChangeObservation()
    }
    
    func deleteExpenses(at offsets: IndexSet) {
        offsets.forEach { index in
            let id = expenseList[index].expenseItem.objectID
            persistenceController.deleteExpense(id: id)
        }
        expenseList.remove(atOffsets: offsets)
        getAllExpenses()
    }
    
    func getAllExpenses() {
        // Fix for notification shimmer bug
//        expenseList = persistenceController.getAllExpenses().map(ExpenseItemViewModel.init).sorted()
        expenseList = persistenceController.getAllExpenses().compactMap { cdExpense in
            let expense = ExpenseItemViewModel(expenseItem: cdExpense)
            if isExpenseInFilteredRange(expense) {
                return expense
            } else {
                return nil
            }
        }.sorted()
    }
    
    func setExpenses(to expenses: [ExpenseItemViewModel]) {
        // Fix for notification shimmer bug
        expenseList = expenses.compactMap { expense in
            if isExpenseInFilteredRange(expense) {
                return expense
            } else {
                return nil
            }
        }
    }
    
    func saveExpense(name: String, type: String, amount: Double, note: String) {
        persistenceController.saveExpense(name: name, type: type, amount: amount, note: note)
        getAllExpenses()
    }
    
    func setupRemoteChangeObservation() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchChanges),
            name: NSNotification.Name(rawValue: Constants.CoreDataKeys.CLOUDKIT_CHANGE_NOTIFICATION),
            object: persistenceController.container.persistentStoreCoordinator
        )
    }
    
    
    @objc func fetchChanges(_ notification: Notification) {
        let expenses = persistenceController.getAllExpenses().map(ExpenseItemViewModel.init).sorted()
        if hasNewChanges(expenses) {
            DispatchQueue.main.async { [weak self] in
                self?.setExpenses(to: expenses)
            }
        }
    }
    
    func hasNewChanges(_ expenses: [ExpenseItemViewModel]) -> Bool{
        if expenses.count != expenseList.count { return true }
        for (oldExpenseVM, newExpenseVM) in zip(expenses, expenseList) {
            if oldExpenseVM != newExpenseVM {
                return true
            }
        }
        return false
    }
    
    func deleteAllExpenses() {
        expenseList.forEach { expense in
            let id = expense.id
            persistenceController.deleteExpense(id: id)
        }
        expenseList.removeAll(keepingCapacity: true)
        getAllExpenses()
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
