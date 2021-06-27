//
//  StringInterpolationExtensions.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(formatDate value: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full

        let dateString = formatter.string(from: value)
        appendLiteral(dateString)
    }
}
