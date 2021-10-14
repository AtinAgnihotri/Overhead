//
//  UserPrefs.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation

struct UserPrefsCompanion: Equatable {
    let currency: String
    let monthlyLimit: Double?
    
    init(currency: String, monthlyLimit: Double?) {
        self.currency = currency
        self.monthlyLimit = monthlyLimit
    }
    
    init(_ userPrefs: CDUserPrefs?) {
        print("Jenga init, \(userPrefs?.currency), \(userPrefs?.monthyLimit)")
        self.currency = userPrefs?.currency ?? "$"
        if let monthlyLimit = userPrefs?.monthyLimit {
            self.monthlyLimit = Double(truncating: monthlyLimit)
        } else {
            self.monthlyLimit = nil
        }
    }
    
    static func ==(lhs: UserPrefsCompanion, rhs: UserPrefsCompanion) -> Bool {
        let currencyCheck = lhs.currency == rhs.currency
        let monthlyLimitCheck = lhs.monthlyLimit == rhs.monthlyLimit
        return currencyCheck && monthlyLimitCheck
    }
}
