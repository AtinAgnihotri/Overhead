//
//  LimitsViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 13/10/21.
//

import Foundation

class LimitsViewModel: ObservableObject {
    
    @Published var spendingLimit = ""
    
    private let settingsManager = SettingsManager.shared
    var initialised = false
    
    var monthlyLimit: String {
        var str = "No Set Limit"
        if let monthlyLimit = settingsManager.monthyLimit, monthlyLimit != 0 {
            str = String(monthlyLimit)
        }
        return str
    }
    
    init() {
        
        defer { initialised.toggle() }
    }
    
}
