//
//  ExpensePieChartView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import SwiftUI

struct ExpensePieChartView: View {
    @ObservedObject private var expenseListVM: ExpenseListViewModel
    private var width: CGFloat
    private var height: CGFloat
    
    init(_ expenseListVM: ExpenseListViewModel, width: CGFloat, height: CGFloat) {
        self.expenseListVM = expenseListVM
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Section {
            PieChartWithLegend(chartData: expenseListVM.pieChartData,
                               legendWidth: 100,
                               chartColors: ExpenseType.chartColors,
                               circlet: true,
                               centerText: "$\(expenseListVM.total, specifier: "%.2f")")
                .frame(width: width, height: height)
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .transition(.asymmetric(insertion: .slide,
                                        removal: .scale))
                .animation(.easeInOut(duration: 1))
        }
        .padding(.vertical)
//        .background(Color.green)
    }
}
struct ExpensePieChartView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = "Test Expense"
        expense.amount = 1.22
        expense.date = Date()
        expense.type = "Personal"
        let expenseVM = ExpenseItemViewModel(expenseItem: expense)
        let expenseListVM = ExpenseListViewModel.getInstance()
        expenseListVM.expenseList = [expenseVM]
        return GeometryReader { geo in
            ExpensePieChartView(expenseListVM, width: geo.size.width, height: geo.size.height * 0.4)
        }
    }
}
