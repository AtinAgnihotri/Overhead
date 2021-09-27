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
        SystemNavBarButton(systemName: "square.and.pencil", action: action)
    }
}

struct DeleteNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        SystemNavBarButton(systemName: "trash", action: action)
            .foregroundColor(.red)
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

struct TickNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        SystemNavBarButton(systemName: "checkmark.circle", action: action)
            .foregroundColor(.green)
    }
}

struct CrossNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        SystemNavBarButton(systemName: "xmark.circle", action: action)
            .foregroundColor(.red)
    }
}