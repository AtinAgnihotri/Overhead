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
                    if !expenseManager.expenseList.isEmpty {
                        Spacer(minLength: geo.size.height * 0.02)
                        ExpensePieChartView(width: geo.size.width * 0.95,
                                        height: geo.size.height * 0.4)
                    }
                    Spacer()
                    ExpenseListView()
                }
            }
            .navigationBarTitle("Expense Tracker")
            .navigationBarItems(leading: SettingsNavBarButton(action: showSettings),
                                trailing: AddNavBarButton(action: addItem))
//                                trailing: HStack {
//                                    SearchNavBarButton {
//                                        print("Search coming soon")
//                                    }.padding()
//                                    AddNavBarButton(action: addItem)
//                                })
//            .navigationBarItems(trailing: AddNavBarButton(action: addItem))
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(item: $activeSheet) { item in
            switch item {
                case .add_expense: AddExpenseView()
                case .settings: SettingsView() // Add SettingsView here later
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
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = "Test Expense"
        expense.amount = 1.22
        expense.date = Date()
        expense.type = "Personal"
        let expenseVM = ExpenseItemViewModel(expenseItem: expense)
        let expenseListVM = ExpenseManager.shared
        expenseListVM.expenseList = [expenseVM]
        return ContentView().environment(\.managedObjectContext, PersistenceManager.preview.container.viewContext)
    }
}


