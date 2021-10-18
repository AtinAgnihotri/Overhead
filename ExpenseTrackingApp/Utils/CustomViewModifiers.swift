//
//  CustomViewModifiers.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI
import Combine

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

struct SecondaryListBackground: ViewModifier {
    let secondaryBackgroundColor = Color(UIColor.secondarySystemFill)
    func body(content: Content) -> some View {
        content.listRowBackground(secondaryBackgroundColor)
    }
}

struct TertiaryListBackground: ViewModifier {
    let tertiaryBackgroundColor = Color(UIColor.tertiarySystemFill)
    func body(content: Content) -> some View {
        content.listRowBackground(tertiaryBackgroundColor)
    }
}

struct RunWhenKeyboardHides: ViewModifier {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    action()
                }
    }
}

struct RunWhenKeyboardShows: ViewModifier {
    let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                    action()
                }
    }
}

struct AdaptsToSoftwareKeyboard: ViewModifier {

    @State var currentHeight: CGFloat = 0
    @State private var cancelable: AnyCancellable?
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, self.currentHeight)
            .edgesIgnoringSafeArea(self.currentHeight == 0 ? Edge.Set() : .bottom)
            .onAppear(perform: subscribeToKeyboardEvents)
    }

    private let keyboardWillOpen = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height }

    private let keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }

    private func subscribeToKeyboardEvents() {
        self.cancelable = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.self.currentHeight, on: self)
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
    
    func adaptsToKeyboard() -> some View {
        self.modifier(AdaptsToSoftwareKeyboard())
    }
    
    func secondaryListBackground() -> some View {
        self.modifier(SecondaryListBackground())
    }
    
    func tertiaryListBackground() -> some View {
        self.modifier(TertiaryListBackground())
    }
    
    func runWhenKeyboardHides(action: @escaping () -> Void) -> some View {
        self.modifier(RunWhenKeyboardHides(action: action))
    }
    
    func runWhenKeyboardShows(action: @escaping () -> Void) -> some View {
        self.modifier(RunWhenKeyboardShows(action: action))
    }
}




