//
//  Constants.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 15/10/21.
//

import Foundation
import SwiftUI

struct Constants {
    
    struct Global {
        static let appName = "OVERHEAD"
    }
    
    struct Views {
        
        static let basePadding: CGFloat = 5
        static let baseRadius: CGFloat = 10
        
        struct Legend {
            static let title = "Legend"
            static let defaultSize = CGSize(width: 20, height: 20)
            static let defaultBorderWidth: CGFloat = 1
            static let baseRadius: CGFloat = 2
            static let baseSpace: CGFloat = 0.1
        }
        
        struct PieChart {
            static let possibleColors: [Color] = [.red, .blue, .green, .orange, .pink, .purple, .red, .yellow]
            static let heightFactor: CGFloat = 0.3
            static let widthFactor: CGFloat = 0.95
            static let spacerWidthFactor: CGFloat = 0.02
        }
        
        struct DayPicker {
            static let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            static let padding: CGFloat = 3
        }
        
        struct Settings {
            static let currencies = ["د.إ", "$", "৳", "R$", "ب.د", "₣", "¥", "₡", "kr", "€", "ლ", "₵", "D", "L", "Kn", "G", "Rp", "₪", "₹", "Sh", "₩", "د.ك", "Rs"]
        }
    }
    
    struct Alerts {
        struct RejectedNotificationPermissions {
            static let title = "Notification Permissions Rejected"
            static let message = "Please allow notifications from Settings to get reminders on your limit"
        }
        
        struct DeleteAllExpenses {
            static let title = "Confirm Deletion"
            static let message = "Are you sure you want to delete all the expenses?"
        }
        
        struct ResetSettings {
            static let title = "Confirm Reset"
            static let message = "Are you sure you want to reset the settings?"
        }
        
        struct ResetLimit {
            static let title = "Confirm Reset"
            static let failedResetTitle = "Nothing to reset"
            static let message = "Do you want to reset all the limits?"
        }
    }
    
    struct Colors {
        struct PieChart {
            static let personal = Color(red: 255/255, green: 153/255, blue: 153/255)
            static let business = Color(red: 51/255, green: 102/255, blue: 102/255)
            static let other = Color(red: 102/255, green: 153/255, blue: 153/255)
        }
    }
    
    struct CoreDataKeys {
        static let COREDATA_CLOUDKIT_CONTAINER = "iCloud.ExpenseTrackingApp"
        static let CLOUDKIT_CHANGE_NOTIFICATION = "NSPersistentStoreRemoteChangeNotification"
    }
    
    struct UserPrefKeys {
        static let REMINDERS_ON_KEY = "EXPENSETRACKINGAPP_REMINDERS_ON"
        static let REMINDERS_STORE_KEY = "EXPENSETRACKINGAPP_REMINDERS_STORE"
    }
    
    struct Types {
        typealias RefreshHandler = () -> Void
    }
    
}
