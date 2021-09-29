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

struct AdaptsToSoftwareKeyboard: ViewModifier {
  @State var currentHeight: CGFloat = 0

  func body(content: Content) -> some View {
    content
      .padding(.bottom, currentHeight)
      .edgesIgnoringSafeArea(.bottom)
      .onAppear(perform: subscribeToKeyboardEvents)
  }

  private func subscribeToKeyboardEvents() {
    NotificationCenter.Publisher(
      center: NotificationCenter.default,
      name: UIResponder.keyboardWillShowNotification
    ).compactMap { notification in
        notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
    }.map { rect in
      rect.height
    }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))

    NotificationCenter.Publisher(
      center: NotificationCenter.default,
      name: UIResponder.keyboardWillHideNotification
    ).compactMap { notification in
      CGFloat.zero
    }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
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
}




