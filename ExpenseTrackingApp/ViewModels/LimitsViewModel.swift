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
//            settingsManager.startReminders()
        }
    }
    @Published var setReminder = false {
        
        didSet {
            settingsManager.setReminders = setReminder
        }
    }
    @Published var selectedDays = Set<String>() {
        didSet {
            print(selectedDays)
        }
    }
    @Published var selectedTime = Date()
    
    var currentReminders: String {
        let reminders = settingsManager.reminders
        var currReminders = "No reminders currently set"
        if setReminder && !settingsManager.reminders.isEmpty {
            if let time = reminders.first?.time {
                
                if reminders.count == 7 {
                    currReminders = "Everyday at \(getDateString(from: time))"
                } else {
                    currReminders = "At \(getDateString(from: time)) on \(getDayString(from: reminders))"
                }
            }
        }
        return currReminders
    }
    
    func getDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func getDayString(from reminders: [LimitReminder]) -> String {
        let days = reminders.map { $0.day.rawValue }
        var sortedDays = [String]()
        for day in ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"] {
            if days.contains(day) {
                sortedDays.append(day)
            }
        }
        return sortedDays.joined(separator: ", ")
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
        initDays()
        initReminders()
        setReminder = settingsManager.setReminders
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
        setReminder = false
        spendingLimit = ""
    }
    
    func initDays() {
        let days = settingsManager.reminders.map { $0.day.rawValue }
        selectedDays = Set<String>(days)
    }
    
    func initReminders() {
        currentlySelectedTime = settingsManager.reminders.first?.time
        if let currTime = currentlySelectedTime {
            selectedTime = currTime
        }
    }
    
    private var currentlySelectedTime: Date? = nil
    
    func saveReminders() {
        print("ExpenseSave Reminders")
        settingsManager.reminders = selectedDays.map {
            LimitReminder(id: UUID().uuidString, day: RemindersDays(rawValue: $0)!, time: selectedTime)
        }
        // A hack to update the view
        let setReminder = self.setReminder
        self.setReminder = setReminder
//        setReminder = setReminder
    }
    
}
