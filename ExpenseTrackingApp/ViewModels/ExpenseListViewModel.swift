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
    
    private var persistenceController = PersistenceManager.shared
    
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
    
    func getPieChartData() -> Dictionary<String, Double> {
        var total = 0.0
        var pieChartData = [String: Double]()
        for expense in expenseList {
            let type = expense.type
            let amount = expense.amount
            
            total += amount
            
            if pieChartData.keys.contains(type) {
                pieChartData[type]! += amount
            } else {
                pieChartData[type] = amount
            }
        }
        
        for type in pieChartData.keys {
            pieChartData[type] = pieChartData[type]! / total
        }
        
        print(pieChartData)
        
        return pieChartData
    }
    
    private init() {
        // Get items from DataModel on startup
        getAllExpenses()
    }
    
    static func getInstance() -> ExpenseListViewModel {
        return shared
    }
    
}
