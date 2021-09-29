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
    
    init(expenseItem: CDExpenseItem) {
        self.expenseItem = expenseItem
    }
    
    var name: String {
        expenseItem.name ?? "Unknown Name"
    }
    
    var amount: Double {
        guard let decimalAmount = expenseItem.amount else { return 0 }
        return Double(truncating: decimalAmount)
    }
    
    var date: Date {
        expenseItem.date ?? Date()
    }
    
    var type: ExpenseType {
//        expenseItem.type ?? "Unknown Type"
        var type: ExpenseType
        if let expenseType = expenseItem.type {
            type = ExpenseType.init(rawValue: expenseType) ?? ExpenseType.other
        } else {
            type = ExpenseType.other
        }
        return type
    }
    
    var note: String {
        expenseItem.note ?? ""
    }
    
    var id: NSManagedObjectID {
        expenseItem.objectID
    }
    
    static func ==(lhs: ExpenseItemViewModel, rhs: ExpenseItemViewModel) -> Bool {
        let nameCheck = lhs.name == rhs.name
        let dateCheck = lhs.date == rhs.date
        let amountCheck = lhs.amount == rhs.amount
        let typeCheck = lhs.type == rhs.type
        let noteCheck = lhs.note == rhs.note
        return nameCheck && dateCheck && amountCheck && typeCheck && noteCheck
    }
    
    static func < (lhs: ExpenseItemViewModel, rhs: ExpenseItemViewModel) -> Bool {
        lhs.date < rhs.date
    }
    
    func updateItem(name: String?, type: ExpenseType?, amount: Double?, note: String?) {
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
        ExpenseListViewModel.getInstance().getAllExpenses()
    }
    
    func deleteItem() {
        PersistenceManager.shared.deleteExpense(id: expenseItem.objectID)
    }
}
