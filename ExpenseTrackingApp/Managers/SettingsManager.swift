//
//  SettingsManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import Foundation
import UserNotifications
import UIKit

class SettingsManager: ObservableObject {
    static let shared = SettingsManager()
   
    private var persistenceManager = PersistenceManager.shared
    private let notificationCenter = UNUserNotificationCenter.current()
    private let foregroundNotificationHandler = ForegroundNotificationHandler()
    
    @Published var userPref: UserPrefsCompanion {
        didSet {
            persistenceManager.setPreferences(to: userPref)
            DispatchQueue.main.async {
                ExpenseManager.shared.getAllExpenses()
            }
        }
    }
    
    var setReminders = false {
        didSet {
            persistenceManager.setReminders(areOn: setReminders, reminders: reminders)
            if setReminders {
                startReminders()
                requestAuthorisation()
            } else {
                invalidateReminders()
            }
        }
    }
    
    var reminders = [LimitReminder]() {
        willSet {
            if setReminders {
                invalidateReminders()
            }
        }
        didSet {
            persistenceManager.setReminders(areOn: setReminders, reminders: reminders)
            if setReminders {
                startReminders()
            }
        }
    }
    
    var currency: String {
        userPref.currency
    }
    
    var monthyLimit: Double? {
        userPref.monthlyLimit
    }
    
//    private override init() {
    private init() {
        let cdUserPref = persistenceManager.getPreferences()
        self.userPref = UserPrefsCompanion(cdUserPref)
        let alarmPrefs = persistenceManager.getReminders()
        self.setReminders = alarmPrefs.setReminders
        self.reminders = alarmPrefs.limitReminders
        requestAuthorisation()
        setupRemoteChangeObservation()
    }
    
    private func setupRemoteChangeObservation() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(fetchUserPrefChanges),
            name: NSNotification.Name(rawValue: Constants.CoreDataKeys.CLOUDKIT_CHANGE_NOTIFICATION),
            object: persistenceManager.container.persistentStoreCoordinator
        )
    }
    
    @objc private func fetchUserPrefChanges() {
        if let newCDUserPref = persistenceManager.getPreferences() {
            print()
            let newPrefs = UserPrefsCompanion(newCDUserPref)
            if newPrefs != userPref {
                DispatchQueue.main.async { [weak self] in
                    self?.userPref = newPrefs
                }
            }
        }
    }
    
    func setCurrency(to denomination: String) {
        setUserPrefs(currency: denomination, limit: userPref.monthlyLimit)
    }
    
    func setMonthlyLimit(to limit: Double?) {
        setUserPrefs(currency: userPref.currency, limit: limit)
    }
    
    func setUserPrefs(currency: String, limit: Double?) {
        userPref = UserPrefsCompanion(currency: currency, monthlyLimit: limit)
    }
    
    func startReminders() {
        for reminder in reminders {
            startReminder(reminder)
        }
    }
    
    func invalidateReminders() {
        let ids = reminders.map { $0.id }
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ids)
    }
    
    func startReminder(_ reminder: LimitReminder) {
        guard let content = getNotificationContent() else { return }
        let trigger = getNotificationTrigger(for: reminder)
        let request = UNNotificationRequest(identifier: reminder.id,
                    content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getNotificationContent() -> UNMutableNotificationContent? {
        guard let limit = monthyLimit else {
            return nil
        }
        let content = UNMutableNotificationContent()
        content.title = Constants.Global.appName
        content.body = "You're monthly limit is \(currency) \(limit)"
        content.sound = UNNotificationSound.default
        return content
    }
    
    func getNotificationTrigger(for reminder: LimitReminder) -> UNCalendarNotificationTrigger {
        var dateComponents = reminder.day.dateComponenet
        let timeComponent = Calendar.current.dateComponents([.hour, .minute], from: reminder.time)
        dateComponents.hour = timeComponent.hour
        dateComponents.minute = timeComponent.minute
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    }
    
    func requestAuthorisation() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] granted, error in
            if !granted || error != nil {
                self?.presentRejectedAuthorisationAlert()
            } else if granted {
                print("Notification Permission successfully granted")
            }
        }
    }
    
    func resetSettings() {
        setUserPrefs(currency: "$", limit: nil)
        setReminders = false
        reminders.removeAll()
    }
    
    func presentRejectedAuthorisationAlert() {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(getRejectedAuthorisationAlert(), animated: true)
        }
    }
    
    func getRejectedAuthorisationAlert() -> UIViewController {
        let rejectedNotificationConstants = Constants.Alerts.RejectedNotificationPermissions.self
        let alertVC = UIAlertController(title: rejectedNotificationConstants.title,
                                        message: rejectedNotificationConstants.message,
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        return alertVC
    }
    
}
