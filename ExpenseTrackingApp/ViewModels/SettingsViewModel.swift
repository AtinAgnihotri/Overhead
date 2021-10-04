//
//  SettingsViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var currency = "$" {
        didSet {
            if initialised {
                SettingsManager.shared.setCurrency(to: currency)
            }
        }
    }
    @Published var spendingLimit = ""
    
    var initialised = false
    
    private let settingsManager = SettingsManager.shared
    
    init() {
        self.currency = settingsManager.currency
        initialised = true
    }
    
}
