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
                return Color(red: 230/255, green: 126/255, blue: 34/255)
            case .business:
                return Color(red: 22/255, green: 160/255, blue: 133/255)
            case .other:
                return Color(red: 155/255, green: 89/255, blue: 182/255)
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
