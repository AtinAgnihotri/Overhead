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

class ExpenseListViewModel: ObservableObject {
    static private var shared = ExpenseListViewModel()
    
    private var persistenceController = PersistenceManager.shared
    
    @Published var expenseList = [ExpenseItemViewModel]()
    
    
    func deleteExpenses(at offset: IndexSet) {
        offset.forEach { index in
            let id = expenseList[index].expenseItem.objectID
            persistenceController.deleteExpense(id: id)
        }
        expenseList.remove(atOffsets: offset)
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
    
    private init() {
        // Get items from DataModel on startup
        getAllExpenses()
        setupRemoteChangeObservation()
    }
    
    func setupRemoteChangeObservation() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchChanges),
            name: NSNotification.Name(rawValue: "NSPersistentStoreRemoteChangeNotification"),
            object: persistenceController.container.persistentStoreCoordinator
        )
    }
    
    @objc func fetchChanges() {
        print("Fetching Changes")
        let expenses = persistenceController.getAllExpenses().map(ExpenseItemViewModel.init).sorted()
        if hasNewChanges(expenses) {
            DispatchQueue.main.async { [weak self] in
                self?.setExpenses(to: expenses)
            }
        }
    }
    
    static func getInstance() -> ExpenseListViewModel {
        return shared
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
    
    func hasNewChanges(_ expenses: [ExpenseItemViewModel]) -> Bool{
        if expenses.count != expenseList.count { return true }
        for (oldExpenseVM, newExpenseVM) in zip(expenses, expenseList) {
            if oldExpenseVM != newExpenseVM {
                return true
            }
        }
        return false
    }
    
}
