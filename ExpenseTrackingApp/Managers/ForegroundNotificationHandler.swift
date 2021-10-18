//
//  ForegroundNotificationHandler.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 16/10/21.
//

import Foundation
import UserNotifications

class ForegroundNotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            // Stub for center handling notification clicks
        }
        
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if isAppsNotification(identifier: notification.request.identifier) {
            completionHandler([.sound, .badge, .banner])
        }
    }
    
    private func isAppsNotification(identifier: String) -> Bool {
        var val = false
        SettingsManager.shared.reminders.forEach { reminder in
            if reminder.id == identifier {
                val = true
            }
        }
        return val
    }
}
