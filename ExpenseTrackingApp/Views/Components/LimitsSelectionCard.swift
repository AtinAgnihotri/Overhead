//
//  LimitSelectionCard.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 13/10/21.
//

import SwiftUI

struct LimitsSelectionCard: View {
    var refreshSettings: Constants.Types.RefreshHandler?
    
    private var currentLimit: String {
        var str = "No limit set"
        let settingsManager = SettingsManager.shared
        if let limit = settingsManager.monthyLimit {
            if limit != 0 {
                let currency = settingsManager.currency
                str = "Set to \(currency) \(limit)"
            }
        }
        return str
    }
    
    var body: some View {
        Section(header: Text("Monthly Limits")) {
            NavigationLink(destination: LimitsView(refreshSettings: refreshSettings)) {
                Text("Limits")
                Spacer()
                Text(currentLimit)
                    .foregroundColor(.blue)
            }.secondaryListBackground()
        }
    }
}

struct LimitSelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        LimitsSelectionCard()
    }
}
