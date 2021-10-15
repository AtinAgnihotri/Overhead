//
//  LimitReminder.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 15/10/21.
//

import Foundation

enum RemindersDays: String, Codable {
    case mon = "Mon"
    case tue = "Tue"
    case wed = "Wed"
    case thu = "Thu"
    case fri = "Fri"
    case sat = "Sat"
    case sun = "Sun"
}

extension RemindersDays {
    var dateComponenet: DateComponents {
        var component = DateComponents()
        switch self {
            case .mon:
                component.weekday = 2
            case .tue:
                component.weekday = 3
            case .wed:
                component.weekday = 4
            case .thu:
                component.weekday = 5
            case .fri:
                component.weekday = 6
            case .sat:
                component.weekday = 7
            case .sun:
                component.weekday = 1
        }
        return component
    }
}

struct LimitReminder: Codable {
    let name: String
    let id: String
    let day: RemindersDays
    let time: Date
}
