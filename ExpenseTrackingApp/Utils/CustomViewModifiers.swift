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

extension View {
    func centerItemInForm() -> some View {
        self.modifier(CenterItemInForm())
    }
}
