//
//  ExpenseManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation

class ExpenseManager: ObservableObject {
    static private var shared = ExpenseManager()
    
    @Published var expenseList = [ExpenseItem]() 
    
    private init() { }
    
    static func getInstance() -> ExpenseManager {
        return shared
    }
}
