//
//  AppNavTitle.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 24/10/21.
//

import SwiftUI

struct AppNavTitle: View {
    var body: some View {
        HStack {
            Text("BILL")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Constants.Colors.PieChart.other)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: -3))
            Text("FOLD")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor( Constants.Colors.PieChart.personal)
                .padding(EdgeInsets(top: 0, leading: -3 , bottom: 5, trailing: 5))
            Spacer()
        }
    }
}
