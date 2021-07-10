//
//  ExpenseManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation
import CoreData

class ExpenseManager: ObservableObject {
    static private var shared = ExpenseManager()
    
//    private static let moc = PersistenceController.viewContext
    
    @Published var expenseList = [ExpenseItemViewModel]()
    
    
    func deleteExpenses(at offset: IndexSet) {
        offset.forEach { index in
            let id = expenseList[index].expenseItem.objectID
            guard let toBeDeleted = PersistenceController.shared.getExpenseByID(id: id) else { return }
            PersistenceController.viewContext.delete(toBeDeleted)
            saveContext()
        }
        expenseList.remove(atOffsets: offset)
        getAllExpenses()
    }
    
    func getAllExpenses() {
        expenseList = PersistenceController.shared.getAllExpenses().map(ExpenseItemViewModel.init)
    }
    
    func saveExpense(name: String, type: String, amount: Double) {
        let expense = CDExpenseItem(context: PersistenceController.viewContext)
        expense.name = name
        expense.type = type
        expense.date = Date()
        expense.amount = NSDecimalNumber(decimal: Decimal(amount))
        saveContext()
        getAllExpenses()
    }
    
    private init() {
        // Get items from DataModel on startup
        getAllExpenses()
    }
    
    func saveContext() {
        if PersistenceController.viewContext.hasChanges {
            do {
                try PersistenceController.viewContext.save()
            } catch {
                PersistenceController.viewContext.rollback()
                print(error.localizedDescription)
            }
        }
    }
    
    static func getInstance() -> ExpenseManager {
        return shared
    }
    
    // Once we send in the CDExpenseItem, if we change it in detail view, and then save, that will do the update operation
}
