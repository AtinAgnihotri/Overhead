//
//  CustomViewModifiers.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI

struct CenterItemInForm: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity,
                   alignment: .center)
    }
}

struct TertiaryBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().backgroundColor = .tertiarySystemFill
            }
            .onDisappear() {
                UITableView.appearance().backgroundColor = .clear
            }
    }
}

struct ClearBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().backgroundColor = .clear
            }
    }
}

extension View {
    func centerItemInForm() -> some View {
        self.modifier(CenterItemInForm())
    }
    
    func tertiaryBackground() -> some View {
        self.modifier(TertiaryBackgroundColor())
    }
    
    func clearBackground() -> some View {
        self.modifier(ClearBackgroundColor())
    }
}




