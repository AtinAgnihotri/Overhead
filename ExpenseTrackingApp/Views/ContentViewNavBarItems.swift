//
//  ContentViewNavBarItems.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import SwiftUI

struct AddNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "plus.app")
                .font(.title2)
        })
    }
}

struct SearchNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "magnifyingglass")
                .font(.title2)
        })
    }
}

struct SettingsNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Settings")
                .font(.title2)
        }
    }
}

//struct ContentViewNavBarItems_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentViewNavBarItems()
//    }
//}
