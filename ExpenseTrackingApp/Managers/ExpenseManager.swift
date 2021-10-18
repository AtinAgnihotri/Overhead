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
    static public let shared = ExpenseManager()
    
    private let persistenceController = PersistenceManager.shared
    private weak var settingsManager = SettingsManager.shared
    
    @Published var expenseList = [ExpenseItemViewModel]()
    
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
        expenseList = persistenceController.getAllExpenses().map(ExpenseItemViewModel.init).sorted()
    }
    
    func setExpenses(to expenses: [ExpenseItemViewModel]) {
        // Fix for notification shimmer bug
        expenseList = expenses
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
    
}
