//
//  ExpenseManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation

class ExpenseManager: ObservableObject {
    static private var shared = ExpenseManager()
    
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
    
    static func getInstance() -> ExpenseManager {
        return shared
    }
}
