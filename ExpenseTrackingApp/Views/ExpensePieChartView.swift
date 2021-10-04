//
//  ExpensePieChartView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import SwiftUI

struct ExpensePieChartView: View {
    @ObservedObject private var expensePieChartVM = ExpensePieChartViewModel()
    private var width: CGFloat
    private var height: CGFloat
    
    init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
    
    var totalText: LocalizedStringKey {
        let currency = SettingsManager.shared.currency
        let total = expensePieChartVM.total
        return "\(currency)\(total, specifier: "%.2f")"
    }
    
    var totalColor: Color {
        expensePieChartVM.isLimitExceeded ? .red : .primary
    }
    
    var body: some View {
        Section {
            PieChartWithLegend(chartData: expensePieChartVM.pieChartData,
                               legendWidth: 100,
                               chartColors: ExpenseType.chartColors,
                               circlet: true,
                               centerText: totalText,
                               centerTextColor: totalColor)
                .frame(width: width, height: height)
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .transition(.asymmetric(insertion: .slide,
                                        removal: .scale))
                .animation(.easeInOut(duration: 1))
        }
        .padding(.vertical)
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
        let expenseListVM = ExpenseManager.shared
        expenseListVM.expenseList = [expenseVM]
        return GeometryReader { geo in
            ExpensePieChartView(width: geo.size.width, height: geo.size.height * 0.4)
        }
    }
}
