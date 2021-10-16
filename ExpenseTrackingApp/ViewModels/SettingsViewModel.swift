//
//  SettingsViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var currency = "$" {
        didSet { updateCurrency() }
    }
    
    var initialised = false
    
    private let settingsManager = SettingsManager.shared
    
    init() {
        self.currency = settingsManager.currency
        initialised = true
        
    }
    
    func clearAllExpenses() {
        ExpenseManager.shared.deleteAllExpenses()
    }
    
    func updateCurrency() {
        if initialised {
            settingsManager.setCurrency(to: currency)
        }
    }
    
    func resetSettings() {
        settingsManager.resetSettings()
    }

    
}
