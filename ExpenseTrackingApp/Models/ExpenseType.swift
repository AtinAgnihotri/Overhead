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
                return Color(red: 255/255, green: 153/255, blue: 153/255)
            case .business:
                return Color(red: 51/255, green: 102/255, blue: 102/255)
            case .other:
                return Color(red: 102/255, green: 153/255, blue: 153/255)
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
