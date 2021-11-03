//
//  DashboardView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/11/21.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Card {
                        Text("Total Holder")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    
                    HStack {
                        Card {
                            VStack {
                                Text("Income Holder")
                                Text("$000")
                            }
                        }
                        Card {
                            VStack {
                                Text("Income Holder")
                                Text("$000")
                            }
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    
                }
                .frame(width: .infinity, alignment: .center)
            }
            
            .navigationBarTitle("Dashboard")
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
