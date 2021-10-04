//
//  ContentViewNavBarItems.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import SwiftUI

struct SystemNavBarButton: View {
    var systemName: String
    var label: String = ""
    var labelWeight: Font.Weight = .medium
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemName)
                    .font(.title2)
                if !label.isEmpty {
                    Text(label).fontWeight(labelWeight)
                }
            }
        }
    }
}

struct TextBarButton: View {
    var label: String
    var font: Font = .title2
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(font)
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
        TextBarButton(label: "Settings", action: action)
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

struct BackNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            SystemNavBarButton(systemName: "chevron.backward", label: "BACK", action: action)
        }
    }
}

struct DoneNavBarButton: View {
    var action: () -> Void
    
    var body: some View {
        TextBarButton(label: "Done", action: action)
    }
}
