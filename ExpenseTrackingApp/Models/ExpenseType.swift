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
                return Constants.Colors.PieChart.personal
            case .business:
                return Constants.Colors.PieChart.business
            case .other:
                return Constants.Colors.PieChart.other
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
