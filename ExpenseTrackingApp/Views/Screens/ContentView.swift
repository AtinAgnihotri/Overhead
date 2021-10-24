//
//  ContentView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI
import CoreData
import Introspect

enum ActiveSheet: Identifiable {
    case add_expense, settings
    
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var expenseManager = ExpenseManager.shared
    
    @State var activeSheet: ActiveSheet?
    @State private var tableView: UITableView?
    
    private func deselectRows() {
        if let tableView = tableView, let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    HStack {
                        Button(action: showSettings, label: {
                            Text("Settings")
                                .fontWeight(.semibold)
                        }).padding(.horizontal, 20)
                        Spacer()
                        Button(action: addItem, label: {
                            Text(Image(systemName: "plus.app"))
                                .fontWeight(.semibold)
                        }).padding(.horizontal)
                    }.font(.title2)
                    .padding(.vertical, 10)
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
                    if !expenseManager.expenseList.isEmpty {
                        Spacer(minLength: geo.size.height * Constants.Views.PieChart.spacerWidthFactor)
                        ExpensePieChart(width: geo.size.width * Constants.Views.PieChart.widthFactor,
                                            height: geo.size.height * Constants.Views.PieChart.heightFactor)
                        
                    }
                    Spacer(minLength: geo.size.height * Constants.Views.PieChart.spacerWidthFactor)
                    ExpenseList()
                }
            }
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(item: $activeSheet) { item in
            switch item {
                case .add_expense: AddExpenseView()
                case .settings: SettingsView()
            }
        }
        .onAppear {
            UIAppearanceUtils.shared.setTableViewAppearance()
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenseManager.deleteExpenses(at: offset)
    }
    
    func addItem() {
        activeSheet = .add_expense
    }
    
    func showSettings() {
        activeSheet = .settings
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceManager.preview.container.viewContext)
    }
}


