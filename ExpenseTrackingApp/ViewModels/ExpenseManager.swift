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
    
    private static let moc = PersistenceController.viewContext
    
    @Published var expenseList = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(expenseList) {
                UserDefaults.standard.set(data, forKey: "ExpenseItems")
            }
        }
    }
    
    private init() {
        if let expenseData = UserDefaults.standard.data(forKey: "ExpenseItems") {
            let decoder = JSONDecoder()
            if let expenseItems = try? decoder.decode([ExpenseItem].self, from: expenseData ) {
                self.expenseList = expenseItems
                return
            }
        }
        self.expenseList = [ExpenseItem]()
    }
    
    static func saveExpenseItemToDataModel(expenseItem : ExpenseItem) {
        var expense = CDExpenseItem(context: moc)
        expense.name = expenseItem.name
        expense.type = expenseItem.type
        expense.id = UUID()
        expense.date = Date()
        expense.amount = NSDecimalNumber(decimal: Decimal(expenseItem.amount))
        saveContext()
    }
    
    static func saveContext() {
        if moc.hasChanges {
            try? moc.save()
        }
    }
    
    static func getInstance() -> ExpenseManager {
        return shared
    }
}
