//
//  ContentViewNavBarItems.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import SwiftUI

struct SystemNavBarButton: View {
    var systemName: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title2)
        }
    }
}

struct AddNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        SystemNavBarButton(systemName: "plus.app", action: action)
    }
}

struct SearchNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        SystemNavBarButton(systemName: "magnifyingglass", action: action)
    }
}

struct EditNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        SystemNavBarButton(systemName: "pencil.circle", action: action)
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
