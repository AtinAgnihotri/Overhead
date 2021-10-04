//
//  SettingsManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
   
    private var persistenceManager = PersistenceManager.shared
    
    @Published var userPref: UserPrefsCompanion {
        didSet {
            persistenceManager.setPreferences(to: userPref)
            ExpenseManager.shared.getAllExpenses()
        }
    }
    
    var currency: String {
        userPref.currency
    }
    
    var monthyLimit: Double {
        userPref.monthlyLimit
    }
    
    private init() {
        let cdUserPref = persistenceManager.getPreferences()
        self.userPref = UserPrefsCompanion(cdUserPref)
        if cdUserPref == nil {
            persistenceManager.setPreferences(to: self.userPref)
        }
    }
    
//    private func setupRemoteChangeObservation() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(fetchUserPrefChanges),
//            name: NSNotification.Name(rawValue: "NSPersistentStoreRemoteChangeNotification"),
//            object: persistenceManager.container.persistentStoreCoordinator
//        )
//    }
    
    
    func setCurrency(to denomination: String) {
        userPref = UserPrefsCompanion(currency: denomination, monthlyLimit: userPref.monthlyLimit)
    }
    
    func setMonthlyLimit(to limit: Double) {
        userPref = UserPrefsCompanion(currency: userPref.currency, monthlyLimit: limit)
    }
    
}
