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
//        guard let decimalAmount = expenseItem.amount else { return 0 }
//        return Double(truncating: decimalAmount)
        expenseCompanion.amount
    }
    
    var date: Date {
//        expenseItem.date ?? Date()
        expenseCompanion.date
    }
    
    var type: ExpenseType {
//        expenseItem.type ?? "Unknown Type"
//        var type: ExpenseType
//        if let expenseType = expenseItem.type {
//            type = ExpenseType.init(rawValue: expenseType) ?? ExpenseType.other
//        } else {
//            type = ExpenseType.other
//        }
//        return type
        expenseCompanion.type
    }
    
    var note: String {
//        expenseItem.note ?? ""
        expenseCompanion.note
    }
    
    var id: NSManagedObjectID {
        expenseItem.objectID
    }
    
    static func ==(lhs: ExpenseItemViewModel, rhs: ExpenseItemViewModel) -> Bool {
//        let nameCheck = lhs.name == rhs.name
//        let dateCheck = lhs.date == rhs.date
//        let amountCheck = lhs.amount == rhs.amount
//        let typeCheck = lhs.type == rhs.type
//        let noteCheck = lhs.note == rhs.note
//        return nameCheck && dateCheck && amountCheck && typeCheck && noteCheck
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
