//
//  LimitsViewModel.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 13/10/21.
//

import SwiftUI

class LimitsViewModel: ObservableObject {
    
    @Published var spendingLimit = ""
    @Published var isEditingLimit = false {
        willSet {
            updateLimit()
        }
    }
    @Published var setReminder = false
    @Published var selectedDays = Set<String>() {
        didSet {
            print(selectedDays)
        }
    }
    @Published var selectedTime = Date()
    
    var currentReminders: String {
        "No reminders currently set"
    }
    
    
    private let settingsManager = SettingsManager.shared
    var initialised = false
    
    var monthlyLimit: String {
        var str = "No Set Limit"
        if let monthlyLimit = settingsManager.monthyLimit, monthlyLimit != 0 {
            str = String(monthlyLimit)
        }
        return str
    }
    
    var hasLimitSet: Bool {
        if settingsManager.monthyLimit != nil, settingsManager.monthyLimit != 0 {
            return true
        }
        return false
    }
    
    init() {
        defer { initialised.toggle() }
    }
    
    private func updateLimit() {
        guard isEditingLimit else {
            return
        }
        guard let limit = Double(spendingLimit) else {
            spendingLimit = ""
            return
        }
        guard limit != 0 else {
            spendingLimit = ""
            return
        }
        settingsManager.setMonthlyLimit(to: limit)
    }
    
    func resetLimit() {
        settingsManager.setMonthlyLimit(to: nil)
        spendingLimit = ""
    }
    
}
