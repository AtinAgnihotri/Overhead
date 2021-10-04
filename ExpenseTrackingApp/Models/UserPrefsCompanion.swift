//
//  UserPrefs.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation

struct UserPrefsCompanion: Equatable {
    let currency: String
    let monthlyLimit: Double
    
    init(currency: String, monthlyLimit: Double) {
        self.currency = currency
        self.monthlyLimit = monthlyLimit
    }
    
    init(_ userPrefs: CDUserPrefs?) {
        self.currency = userPrefs?.currency ?? "$"
        self.monthlyLimit = Double(truncating: userPrefs?.monthyLimit ?? 0)
    }
    
    static func ==(lhs: UserPrefsCompanion, rhs: UserPrefsCompanion) -> Bool {
        let currencyCheck = lhs.currency == rhs.currency
        let monthlyLimitCheck = lhs.monthlyLimit == rhs.monthlyLimit
        return currencyCheck && monthlyLimitCheck
    }
}
