//
//  ExpenseItem.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    let id = UUID()
    let date: Date
    let name: String
    let amount: Double
    let type: String
    
    init(name: String, amount: Double, type: String) {
        self.date = Date()
        self.name = name
        self.amount = amount
        self.type = type
    }
    
    init(name: String, amount: Double, type: String, date: Date) {
        self.date = date
        self.name = name
        self.amount = amount
        self.type = type
    }
    
    static func ==(lhs: ExpenseItem, rhs: ExpenseItem) -> Bool {
        let nameCheck = lhs.name == rhs.name
        let dateCheck = lhs.date == rhs.date
        let amountCheck = lhs.amount == rhs.amount
        let typeCheck = lhs.type == rhs.type
        return nameCheck && dateCheck && amountCheck && typeCheck
    }
  
}
