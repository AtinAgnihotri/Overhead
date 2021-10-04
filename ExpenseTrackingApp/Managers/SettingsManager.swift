//
//  SettingsManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
    @Published var userPref: UserPrefsCompanion {
        didSet {
            expenseManager?.getAllExpenses()
        }
    }
    private var persistenceManager = PersistenceManager.shared
    private weak var expenseManager = ExpenseManager.shared
    
    private init() {
        self.userPref = UserPrefsCompanion(persistenceManager.getPreferences())
    }
    
    func setCurrency(to denomination: String) {
        
    }
    
    var currency: String {
        userPref.currency
    }
    
    var monthyLimit: Double {
        userPref.monthlyLimit
    }
}
