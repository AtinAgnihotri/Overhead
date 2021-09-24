//
//  ExpenseType.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 24/09/21.
//

import SwiftUI

enum ExpenseType: String, CaseIterable {
    case personal = "Personal"
    case business = "Business"
    case other = "Other"
}

extension ExpenseType {
    var displayColor: Color {
        switch self {
            case .personal:
                return .red
            case .business:
                return .blue
            case .other:
                return .orange
        }
    }
}

extension ExpenseType {
    static var chartColors: [String: Color] {
        var colors = [String: Color]()
        for type in ExpenseType.allCases {
            colors[type.rawValue] = type.displayColor
        }
        return colors
    }
}
