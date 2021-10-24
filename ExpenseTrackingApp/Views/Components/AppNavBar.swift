//
//  AppNavBar.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 24/10/21.
//

import SwiftUI

struct AppNavBar: View {
    
    var settingsTapped: () -> Void
    var addTapped: () -> Void
    
    var body: some View {
        HStack {
            CustomSettingNavBarButton(action: settingsTapped)
            Spacer()
            CustomAddItemNavBarButton(action: addTapped)
        }.font(.title2)
        .padding(.vertical, 10)
    }
}
