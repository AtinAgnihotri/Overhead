//
//  Persistence.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import CoreData
import CloudKit

struct PersistenceManager {
    static let shared = PersistenceManager()
    private let userDefaults = UserDefaults.standard
    
    static var viewContext: NSManagedObjectContext {
        shared.container.viewContext
    }

    static var preview: PersistenceManager = {
        let result = PersistenceManager(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = CDExpenseItem(context: viewContext)
            newItem.name = ""
            newItem.type = ""
            newItem.amount = NSDecimalNumber(value: 0)
            newItem.date = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "ExpenseTrackingApp")
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("Failed to fetch description")
        }
        description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: Constants.CoreDataKeys.COREDATA_CLOUDKIT_CONTAINER)
        let remoteChangeKey = "NSPersistentStoreRemoteChangeNotificationOptionKey"
        description.setOption(true as NSNumber, forKey: remoteChangeKey)
        container.persistentStoreDescriptions = [description]
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
//        defer { setupPreferencesForFirstLaunch() }
    }
    
    func getExpenseByID(id: NSManagedObjectID) -> CDExpenseItem? {
        do {
            return try PersistenceManager.viewContext.existingObject(with: id) as? CDExpenseItem
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getAllExpenses() -> [CDExpenseItem] {
        let request: NSFetchRequest<CDExpenseItem> = CDExpenseItem.fetchRequest()
        do {
            return try PersistenceManager.viewContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
        return [CDExpenseItem]()
    }
    
    
    func saveContext() {
        if PersistenceManager.viewContext.hasChanges {
            do {
                try PersistenceManager.viewContext.save()
            } catch {
                PersistenceManager.viewContext.rollback()
                print(error.localizedDescription)
            }
        }
    }
    
    func saveExpense(name: String, type: String, amount: Double, note: String) {
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = name
        expense.type = type
        expense.date = Date()
        expense.note = note
        expense.amount = NSDecimalNumber(decimal: Decimal(amount))
        saveContext()
    }
    
    func updateExpense(with expenseItem: CDExpenseItem,
                       name: String? = nil,
                       amount: Double? = nil,
                       type: String? = nil,
                       note: String? = nil) {
        
        if let name = name {
            expenseItem.name = name
        }
        if let amount = amount {
            expenseItem.amount = NSDecimalNumber(decimal: Decimal(amount))
        }
        if let type = type {
            expenseItem.type = type
        }
        if let note = note {
            expenseItem.note = note
        }
        saveContext()
    }
    
    func deleteExpense(id: NSManagedObjectID) {
        guard let toBeDeleted = getExpenseByID(id: id) else { return }
        PersistenceManager.viewContext.delete(toBeDeleted)
        saveContext()
    }
    
    func getPreferences() -> CDUserPrefs? {
        let request: NSFetchRequest<CDUserPrefs> = CDUserPrefs.fetchRequest()
        do {
            return try PersistenceManager.viewContext.fetch(request).first
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func setPreferences(to userPref: UserPrefsCompanion) {
        let request: NSFetchRequest<CDUserPrefs> = CDUserPrefs.fetchRequest()
        // Fetches saved pref if present, otherwise creates a new pref
        let savedPref = try? PersistenceManager.viewContext.fetch(request).first
        let pref =  savedPref ?? CDUserPrefs(context: PersistenceManager.viewContext)
        pref.currency = userPref.currency
        if let monthlyLimit = userPref.monthlyLimit {
            pref.monthyLimit = NSDecimalNumber(decimal: Decimal(monthlyLimit))
        } else {
            pref.monthyLimit = nil
        }
        saveContext()
    }
    
    func setupDefaultPreferences() {
        let pref =  CDUserPrefs(context: PersistenceManager.viewContext)
        pref.currency = "$"
        pref.monthyLimit = 0
        saveContext()
    }
    
    func setupPreferencesForFirstLaunch() {
        let request: NSFetchRequest<CDUserPrefs> = CDUserPrefs.fetchRequest()
        if let savedPrefs = try? PersistenceManager.viewContext.fetch(request) {
            if savedPrefs.isEmpty {
                setupDefaultPreferences()
            }
        } else {
            setupDefaultPreferences()
        }
    }
    
    func resetPreferences() {
        let request: NSFetchRequest<CDUserPrefs> = CDUserPrefs.fetchRequest()
        if let savedPrefs = try? PersistenceManager.viewContext.fetch(request) {
            savedPrefs.forEach { pref in
                PersistenceManager.viewContext.delete(pref)
            }
        }
        saveContext()
        print("Reaches here")
    }
    
    func setReminders(areOn: Bool, reminders: [LimitReminder]) {
        userDefaults.set(areOn, forKey: Constants.UserPrefKeys.REMINDERS_ON_KEY)
        if let data = try? JSONEncoder().encode(reminders) {
            userDefaults.setValue(data, forKey: Constants.UserPrefKeys.REMINDERS_STORE_KEY)
        }
        
    }
    
    func getReminders() -> (setReminders: Bool, limitReminders: [LimitReminder]) {
        let setReminders = userDefaults.bool(forKey: Constants.UserPrefKeys.REMINDERS_ON_KEY)
        var limitReminders = [LimitReminder]()
        if let data = userDefaults.data(forKey: Constants.UserPrefKeys.REMINDERS_STORE_KEY) {
            if let reminders = try? JSONDecoder().decode([LimitReminder].self, from: data) {
                limitReminders = reminders
            }
        }
        return (setReminders: setReminders, limitReminders: limitReminders)
    }
    
    // Once we send in the CDExpenseItem, if we change it in detail view, and then save, that will do the update operation
}
