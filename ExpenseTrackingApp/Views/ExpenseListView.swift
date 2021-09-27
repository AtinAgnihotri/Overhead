//
//  ExpenseListView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import SwiftUI
import Introspect


struct ExpenseListView: View {
    @ObservedObject private var expenseListVM: ExpenseListViewModel
    @State private var tableView: UITableView?

    private func deselectRows() {
        if let tableView = tableView, let selectedRow = tableView.indexPathForSelectedRow {
            print("Deselecting rows")
            tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    init(_ expenseListVM: ExpenseListViewModel) {
        self.expenseListVM = expenseListVM
    }
    
    var body: some View {
        List {
            ForEach(expenseListVM.expenseList, id:\.id) { expenseVM in
                NavigationLink(destination: DetailedExpenseView(expenseVM)) {
                    ExpenseListItem(expenseVM)
                        .buttonStyle(PlainButtonStyle())
                }
                .buttonStyle(PlainButtonStyle())
                .id(UUID())
                .onAppear {
                    deselectRows()
                }
            }
            .onDelete(perform: removeItems)
            .buttonStyle(PlainButtonStyle())
            .listRowBackground(Color.clear)
            
        }
        .listStyle(GroupedListStyle())
        .background(Color.clear)
        .clearBackground()
        .introspectTableView(customize: { tableView in
            self.tableView = tableView
        })
    }
    
    func removeItems(at offset: IndexSet) {
        expenseListVM.deleteExpenses(at: offset)
    }
    
    func editItem() {
        print("Edit coming soon")
    }
}

struct ExpenseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListView(DevTestUtils.shared.getExpenseListVM())
    }
}