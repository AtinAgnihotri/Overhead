//
//  Persistence.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import CoreData

struct PersistenceManager {
    static let shared = PersistenceManager()
    
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
    
    func saveExpense(name: String, type: String, amount: Double) {
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = name
        expense.type = type
        expense.date = Date()
        expense.amount = NSDecimalNumber(decimal: Decimal(amount))
        saveContext()
    }
    
    func deleteExpense(id: NSManagedObjectID) {
        guard let toBeDeleted = getExpenseByID(id: id) else { return }
        PersistenceManager.viewContext.delete(toBeDeleted)
        saveContext()
    }
    
    // Once we send in the CDExpenseItem, if we change it in detail view, and then save, that will do the update operation
}
