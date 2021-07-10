//
//  ExpenseItemViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 10/07/21.
//

import Foundation
import CoreData

struct ExpenseItemViewModel: Equatable {
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
    
    var type: String {
        expenseItem.type ?? "Unknown Type"
    }
    
    var id: NSManagedObjectID {
        expenseItem.objectID
    }
    
    static func ==(lhs: ExpenseItemViewModel, rhs: ExpenseItemViewModel) -> Bool {
        let nameCheck = lhs.name == rhs.name
        let dateCheck = lhs.date == rhs.date
        let amountCheck = lhs.amount == rhs.amount
        let typeCheck = lhs.type == rhs.type
        return nameCheck && dateCheck && amountCheck && typeCheck
    }
}
