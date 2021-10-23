//
//  ExpenseItemViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 10/07/21.
//

import Foundation
import CoreData

struct ExpenseItemViewModel: Equatable, Comparable {
    
    
    let expenseItem: CDExpenseItem
    var expenseCompanion: ExpenseCompanion
    
    init(expenseItem: CDExpenseItem) {
        self.expenseItem = expenseItem
        self.expenseCompanion = ExpenseCompanion(expenseItem)
    }
    
    var name: String {
        expenseCompanion.name
    }
    
    var amount: Double {
        expenseCompanion.amount
    }
    
    var date: Date {
        expenseCompanion.date
    }
    
    var type: ExpenseType {
        expenseCompanion.type
    }
    
    var note: String {
        expenseCompanion.note
    }
    
    var id: NSManagedObjectID {
        expenseItem.objectID
    }
    
    static func ==(lhs: ExpenseItemViewModel, rhs: ExpenseItemViewModel) -> Bool {
        lhs.expenseCompanion == rhs.expenseCompanion
    }
    
    static func < (lhs: ExpenseItemViewModel, rhs: ExpenseItemViewModel) -> Bool {
        lhs.date < rhs.date
    }
    
    mutating func updateItem(name: String?, type: ExpenseType?, amount: Double?, note: String?) {
        if let name = name {
            expenseItem.name = name
        }
        if let amount = amount {
            expenseItem.amount = NSDecimalNumber(decimal: Decimal(amount))
        }
        if let type = type?.rawValue {
            expenseItem.type = type
        }
        if let note = note {
            expenseItem.note = note
        }
        PersistenceManager.shared.saveContext()
        expenseCompanion = ExpenseCompanion(expenseItem)
        ExpenseManager.shared.getAllExpenses()
    }
    
    func deleteItem() {
        PersistenceManager.shared.deleteExpense(id: expenseItem.objectID)
    }
}
