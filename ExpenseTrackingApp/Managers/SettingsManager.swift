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
            DispatchQueue.main.async {
                ExpenseManager.shared.getAllExpenses()
            }
//            ExpenseManager.shared.getAllExpenses()
        }
    }
    
    
    var currency: String {
        userPref.currency
    }
    
    var monthyLimit: Double? {
        userPref.monthlyLimit
    }
    
    private init() {
        let cdUserPref = persistenceManager.getPreferences()
        self.userPref = UserPrefsCompanion(cdUserPref)
        if cdUserPref == nil {
            persistenceManager.setPreferences(to: self.userPref)
        }
        setupRemoteChangeObservation()
    }
    
    private func setupRemoteChangeObservation() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchUserPrefChanges),
            name: NSNotification.Name(rawValue: "NSPersistentStoreRemoteChangeNotification"),
            object: persistenceManager.container.persistentStoreCoordinator
        )
    }
    
    @objc private func fetchUserPrefChanges() {
        if let newCDUserPref = persistenceManager.getPreferences() {
            let newPrefs = UserPrefsCompanion(newCDUserPref)
            if newPrefs != userPref {
                DispatchQueue.main.async { [weak self] in
                    self?.userPref = newPrefs
                }
            }
        }
    }
    
    func setCurrency(to denomination: String) {
        userPref = UserPrefsCompanion(currency: denomination, monthlyLimit: userPref.monthlyLimit)
    }
    
    func setMonthlyLimit(to limit: Double?) {
        userPref = UserPrefsCompanion(currency: userPref.currency, monthlyLimit: limit)
    }
    
}
