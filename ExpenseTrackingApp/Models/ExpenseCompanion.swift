//
//  ExpenseCompanion.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 03/10/21.
//

import Foundation

struct ExpenseCompanion: Equatable, Comparable {
    
    let name: String
    let amount: Double
    let type: ExpenseType
    let note: String
    let date: Date
    
    init(_ expenseItem: CDExpenseItem) {
        self.name = expenseItem.name ?? "Unknown name"
        self.amount = Double(truncating: expenseItem.amount ?? 0)
        self.type = ExpenseType(rawValue: expenseItem.type ?? "other") ?? ExpenseType.other
        self.note = expenseItem.note ?? ""
        self.date = expenseItem.date ?? Date()
    }
    
    static func == (lhs: ExpenseCompanion, rhs: ExpenseCompanion) -> Bool {
        let nameCheck = lhs.name == rhs.name
        let dateCheck = lhs.date == rhs.date
        let amountCheck = lhs.amount == rhs.amount
        let typeCheck = lhs.type == rhs.type
        let noteCheck = lhs.note == rhs.note
        return nameCheck && dateCheck && amountCheck && typeCheck && noteCheck
    }
    
    static func < (lhs: ExpenseCompanion, rhs: ExpenseCompanion) -> Bool {
        lhs.date < rhs.date
    }
    
}
