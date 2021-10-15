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
            
            print("Tapped in notification")
        }
        
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
//        if notification.request.identifier == requestIdentifier{
//
//            completionHandler( [.alert,.sound,.badge])
//
//        }
        if isAppsNotification(identifier: notification.request.identifier) {
//            completionHandler( [.alert, .sound, .badge])
            completionHandler([.sound, .badge, .banner])
        }
    }
    
    func isAppsNotification(identifier: String) -> Bool {
        var val = false
        SettingsManager.shared.reminders.forEach { reminder in
            if reminder.id == identifier {
                val = true
            }
        }
        return val
    }
}
