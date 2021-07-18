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

    @ObservedObject var expenseListVM = ExpenseListViewModel.getInstance()
    @State var activeSheet: ActiveSheet?
    @State var currentExpense : CDExpenseItem?
    
    var body: some View {
        /* Workaround for weird iOS 14 bug whereby when first item is added in the list, it will pass the prev value of currentExpense to DetailedExpenseView(currentExpense)
        */
        let localExpense = currentExpense
        return NavigationView {
            GeometryReader { geo in
                VStack {
                    let chartData = expenseListVM.getPieChartData()
                    if chartData.count != 0 {
                        Section {
                            PieChartView(chartData: chartData)
                                .scaledToFit()
                                .frame(width: geo.size.width * 0.4)
//                                .frame(height: 150)
                                .transition(.slide)
                                .animation(.easeInOut(duration: 1))
                        }
                    }
                    
                    Spacer(minLength: 10)
                    
                    List {
                        ForEach(expenseListVM.expenseList, id:\.id) { expenseItemVM in
                            Button( action: {
                                showExpenseDetails(currentExpense: expenseItemVM.expenseItem)
                            }, label: { ExpenseListItem(expenseItemVM) })
                        }.onDelete(perform: removeItems)

                    }
                }
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
        expenseListVM.deleteExpenses(at: offset)
    }
    
    func addItem() {
        activeSheet = .add_expense
    }
    
    func showExpenseDetails(currentExpense: CDExpenseItem) {
        self.currentExpense = currentExpense
        activeSheet = .view_expense
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceManager.preview.container.viewContext)
    }
}
