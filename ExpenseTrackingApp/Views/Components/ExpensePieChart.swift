//
//  ExpensePieChartView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 25/09/21.
//

import SwiftUI

struct ExpensePieChart: View {
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
        return "\(currency) \(total, specifier: "%.2f")"
    }
    
    var totalColor: Color {
        expensePieChartVM.isLimitExceeded ? .red : .primary
    }
    
    var totalFont: Font {
        expensePieChartVM.isLimitExceeded ? .callout : .caption
    }
    
    var totalFontWeight: Font.Weight {
        expensePieChartVM.isLimitExceeded ? .bold : .regular
    }
    
    var body: some View {
        Section {
            VStack {
                PieChartWithLegend(chartData: expensePieChartVM.pieChartData,
                                   legendWidth: 100,
                                   chartColors: ExpenseType.chartColors,
                                   circlet: true,
                                   centerText: totalText,
                                   centerTextColor: totalColor,
                                   centerTextFont: totalFont,
                                   centerTextFontWeight: totalFontWeight)
                    .frame(width: width, height: height)
                    .aspectRatio(contentMode: .fill)
                    .padding(5)
                    .transition(.asymmetric(insertion: .slide,
                                            removal: .scale))
                    .animation(.easeInOut(duration: 1))
            }
        }
        .padding(.vertical)
        .shadow(radius: 10)
    }
}
struct ExpensePieChartView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ExpensePieChart(width: geo.size.width, height: geo.size.height * Constants.Views.PieChart.heightFactor)
        }
    }
}
