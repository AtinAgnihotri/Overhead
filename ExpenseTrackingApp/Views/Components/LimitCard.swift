//
//  LimitCard.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 19/10/21.
//

import SwiftUI

struct LimitCard: View {
    
    @ObservedObject var limitsVM: LimitsViewModel
    var refreshSettings: Constants.Types.RefreshHandler?
    
    var editButtonText: String {
        limitsVM.isEditingLimit ? "Done" : "Edit"
    }
    
    var editButtonColor: Color {
        limitsVM.isEditingLimit ? .blue : .red
    }
    
    init(_ limitsVM: LimitsViewModel, refreshSettings: Constants.Types.RefreshHandler?) {
        self.limitsVM = limitsVM
        self.refreshSettings = refreshSettings
    }
    
    var body: some View {
        Section(header: Text("Monthly Limit")) {
            HStack {
                Button(action: didPressEditButton) {
                    Text(editButtonText)
                        .foregroundColor(editButtonColor)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                if limitsVM.isEditingLimit {
                    TextField("Monthly Limit", text: $limitsVM.spendingLimit)
                        .frame(alignment: .trailing)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                } else {
                    Text(limitsVM.monthlyLimit)
                        .frame(alignment: .trailing)
                }
                
            }
        }.secondaryListBackground()
    }
    
    private func didPressEditButton() {
        limitsVM.isEditingLimit.toggle()
        refreshSettings?()
    }
}
