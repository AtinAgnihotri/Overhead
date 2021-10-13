//
//  KeyboardUtils.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 29/09/21.
//

import Combine
import SwiftUI


final class KeyboardUtils: ObservableObject {
    
    @Published private(set) var keyboardHeight: CGFloat = 0
    @Published var keyboardClosed = false {
        didSet {
            if keyboardClosed {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.keyboardClosed = false
                }
            }
        }
    }
    var adjustmentCallback: ((UITableView) -> Void)?
    
    private var cancellable: AnyCancellable?
    
    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height}
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero}
    
    init() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.self.keyboardHeight, on: self)
    }
    
    func scrollWhenKeyboard(for tableView: UITableView?) {
        var offset = CGPoint(x: 0, y: 0)
        if let tableView = tableView {
            let scrolledHeight = tableView.contentSize.height - tableView.bounds.size.height
            offset = CGPoint(x: 0, y: scrolledHeight)
            tableView.setContentOffset(offset, animated: true)
        }
        
    }
    
    @objc func closeAllKeyboards() {
        keyboardClosed = true
    }
    
}

class KeybordManager: ObservableObject {
    static let shared = KeybordManager()
    
    @Published var keyboardFrame: CGRect? = nil
    
    init() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func willHide() {
        self.keyboardFrame = .zero
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        self.keyboardFrame = keyboardScreenEndFrame
    }
}
