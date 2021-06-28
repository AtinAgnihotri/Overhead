//
//  ContentView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI
import CoreData

enum ActiveSheet: Identifiable {
    case add_expense, view_expense
    
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @ObservedObject var expenseManager = ExpenseManager.getInstance()
    @State var activeSheet: ActiveSheet?
    @State var currentExpense = ExpenseItem(name: "Expense Name", amount: 0, type: "Personal")
    
    var body: some View {
        /* Workaround for weird iOS 14 bug whereby when first item is added in the list, it will pass the prev value of currentExpense to DetailedExpenseView(currentExpense)
        */
        let localExpense = currentExpense
        return NavigationView {
            List {
                ForEach(expenseManager.expenseList) { expenseItem in
                    Button( action: {
                        showExpenseDetails(currentExpense: expenseItem)
                    }, label: { ExpenseListItem(expenseItem) })
                }.onDelete(perform: removeItems)

            }
            .navigationBarTitle("Expense Tracker")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: addItem) {
                                    AddItemImage()
            })
            
        }.sheet(item: $activeSheet) { item in
            switch item {
                case .add_expense:
                    AddExpenseView()
                case .view_expense:
                    DetailedExpenseView(localExpense)
            }
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenseManager.expenseList.remove(atOffsets: offset)
    }
    
    func addItem() {
        activeSheet = .add_expense
    }
    
    func showExpenseDetails(currentExpense: ExpenseItem) {
        self.currentExpense = currentExpense
        activeSheet = .view_expense
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
