//
//  ExpenseItem.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
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
}