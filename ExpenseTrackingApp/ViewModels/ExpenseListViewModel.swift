//
//  ExpenseManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation
import CoreData

class ExpenseListViewModel: ObservableObject {
    static private var shared = ExpenseListViewModel()
    
    private var persistenceController = PersistenceController.shared
    
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
        expenseList = persistenceController.getAllExpenses().map(ExpenseItemViewModel.init)
    }
    
    func saveExpense(name: String, type: String, amount: Double) {
        persistenceController.saveExpense(name: name, type: type, amount: amount)
        getAllExpenses()
    }
    
    private init() {
        // Get items from DataModel on startup
        getAllExpenses()
    }
    
    static func getInstance() -> ExpenseListViewModel {
        return shared
    }
    
}
