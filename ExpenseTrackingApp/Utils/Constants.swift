//
//  Constants.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 15/10/21.
//

import Foundation

struct Constants {
    
    struct Global {
        static let appName = "Expense Tracking App"
    }
    
    struct CoreDataKeys {
        static let COREDATA_CLOUDKIT_CONTAINER = "iCloud.ExpenseTrackingApp"
        static let CLOUDKIT_CHANGE_NOTIFICATION = "NSPersistentStoreRemoteChangeNotification"
    }
    
    struct UserPrefKeys {
        static let REMINDERS_ON_KEY = "EXPENSETRACKINGAPP_REMINDERS_ON"
        static let REMINDERS_STORE_KEY = "EXPENSETRACKINGAPP_REMINDERS_STORE"
    }
    
}
