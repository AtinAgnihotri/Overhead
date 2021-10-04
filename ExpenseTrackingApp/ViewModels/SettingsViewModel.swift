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
    
//    private weak var settingsManager = SettingsManager.shared
    private let settingsManager = SettingsManager.shared
    
    init() {
//        self.currency = SettingsManager.shared.currency
        print("Reaches here 1")
        self.currency = settingsManager.currency
        print("Reaches here 2")
        initialised = true
        print("Reaches here 3")
    }
    
    
}
