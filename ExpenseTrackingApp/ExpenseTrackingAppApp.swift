//
//  ExpenseTrackingAppApp.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI

@main
struct ExpenseTrackingAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
