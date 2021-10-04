//
//  SettingsView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/10/21.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            List {
                Picker(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, selection: <#T##Binding<_>#>, content: <#T##() -> _#>)
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
