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
    case add_expense, view_expense
    
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var expenseListVM = ExpenseListViewModel.getInstance()
    @State var activeSheet: ActiveSheet?
    @State var currentExpense : ExpenseItemViewModel?
    
    var body: some View {
        /* Workaround for weird iOS 14 bug whereby when first item is added in the list, it will pass the prev value of currentExpense to DetailedExpenseView(currentExpense)
        */
        let localExpense = currentExpense
        return NavigationView {
            GeometryReader { geo in
                VStack {
                    if expenseListVM.expenseList.count != 0 {
                        Spacer(minLength: geo.size.height * 0.02)
                        Section {
                            PieChartWithLegend(chartData: expenseListVM.pieChartData,
                                               legendWidth: 100,
                                               chartColors: ExpenseType.chartColors,
                                               circlet: true,
                                               centerText: "$\(expenseListVM.total, specifier: "%.2f")")
                                .aspectRatio(contentMode: .fit)
                                .padding(.vertical)
                                .frame(width: geo.size.width * 0.96)
                                .transition(.asymmetric(insertion: .slide,
                                                        removal: .scale))
                                .animation(.easeInOut(duration: 1))
                        }
                        .padding(.vertical)
                    }
                    Spacer()
                    List {
                        ForEach(expenseListVM.expenseList, id:\.id) { expenseItemVM in
                            ExpenseListItem(expenseItemVM)
                                .listRowBackground(Color.secondary)
                                .background(NavigationLink(
                                                destination: DetailedExpenseView(expenseItemVM),
                                                label: {}))
                        }
                        .onDelete(perform: removeItems)
                    }.clearBackground()
                    .padding(.vertical)
                }
            }
            .background(Color(UIColor.tertiarySystemFill)
            .edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Expense Tracker")
            .navigationBarItems(leading: Button(action: {print("Search coming soon")}) {
                                            Text("Settings")
                                                .font(.title2)
                                        },
                                trailing: HStack {
                                    Button(action: {print("Search coming soon")}) {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title2)
                                    }
                                    .padding()
                                    Button(action: addItem) {
                                        Image(systemName: "plus.app")
                                            .font(.title2)
                                    }
                                })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(item: $activeSheet) { item in
            switch item {
                case .add_expense:
                    AddExpenseView()
                case .view_expense:
                    if let expenseVM = localExpense {
                        DetailedExpenseView(expenseVM)
                    }
            }
        }
        .onAppear {
            UIAppearanceUtils.shared.setTableViewAppearance()
        }
    }
    
    func removeItems(at offset: IndexSet) {
        expenseListVM.deleteExpenses(at: offset)
    }
    
    func addItem() {
        activeSheet = .add_expense
    }
    
    func showExpenseDetails(for expenseVM: ExpenseItemViewModel) {
        self.currentExpense = expenseVM
        activeSheet = .view_expense
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceManager.preview.container.viewContext)
    }
}
