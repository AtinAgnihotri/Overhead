//
//  UserPrefs.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation

struct UserPrefsCompanion {
    let currency: String
    let monthlyLimit: Double
    
    init(_ userPrefs: CDUserPrefs?) {
        self.currency = userPrefs?.currency ?? "$"
        self.monthlyLimit = Double(truncating: userPrefs?.monthyLimit ?? 0)
    }
}
