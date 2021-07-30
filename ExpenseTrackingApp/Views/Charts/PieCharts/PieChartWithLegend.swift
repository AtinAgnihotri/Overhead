//
//  PieChartWithLegend.swift
//  SwiftUIScratchPad
//
//  Created by Atin Agnihotri on 27/07/21.
//

import SwiftUI

struct PieChartWithLegend: View {
    enum LegendAlignment {
        case vertical
        case horizontal
    }
    
    let chartData: Dictionary<String, Double>
    let total: Double
    let percentFont: Font
    var dataKeys: [String] {
        Array(chartData.keys)
    }
    let percentColor: Color
    let alignment: LegendAlignment
    
    let chartColors: [String: Color]?
    
    let circlet: Bool
    let centerText: LocalizedStringKey?
    let centerColor: Color
    let centerTextColor: Color
    let centerTextFont: Font
    
    let legendTitle: String
    let withBorder: Bool
    let legendWidth: CGFloat
    let legendFont: Font
    let cubeSize: CGSize
    let borderWidth: CGFloat
    let borderColor: Color
    
    var dataColors: [String: Color] {
        if let colors = chartColors {
            return colors
        } else {
            var colors = [String: Color]()
            let possibleColors: [Color] = [.red, .blue, .green, .orange, .pink, .purple, .red, .yellow]
            var indx = 0
            for eachKey in dataKeys {
                colors[eachKey] = possibleColors[indx]
                indx = indx + 1 < possibleColors.count ? indx + 1 : 0
            }
            return colors
        }
    }
    
    init(chartData: Dictionary<String, Double>,
         legendWidth: CGFloat = .infinity,
         chartColors: [String: Color]? = nil,
         font percentFont: Font = .caption,
         percentColor: Color = .white,
         alignment: LegendAlignment = .horizontal,
         circlet: Bool = false,
         centerText: LocalizedStringKey? = nil,
         centerColor: Color = Color(UIColor.tertiarySystemFill),
         centerTextColor: Color = Color.primary,
         centerTextFont: Font = .caption,
         title legendTitle: String = "Legend",
         withBorder: Bool = true,
         font: Font = .caption,
         cubeSize: CGSize = CGSize(width: 20, height: 20),
         borderWidth: CGFloat = 1,
         borderColor: Color = .primary) {
        
        total = Array(chartData.values).reduce(0, +)
        var percentageData = chartData
        for key in percentageData.keys {
            percentageData[key] = percentageData[key]! / total
        }
        self.chartData = percentageData
        self.legendWidth = legendWidth
        self.chartColors = chartColors
        self.percentFont = percentFont
        self.percentColor = percentColor
        self.alignment = alignment
        self.circlet = circlet
        self.centerText = centerText
        self.centerColor = centerColor
        self.centerTextColor = centerTextColor
        self.centerTextFont = centerTextFont
        self.legendTitle = legendTitle
        self.withBorder = withBorder
        self.legendFont = font
        self.cubeSize = cubeSize
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
    
    var body: some View {
        if alignment == .vertical {
            getVerticallyAlignedChart()
        } else {
            getHorizontallyAlignedChart()
        }
    }
    
    func getHorizontallyAlignedChart() -> some View {
        HStack {
            getPieChart()
            getLegend()
        }
    }
    
    func getVerticallyAlignedChart() -> some View {
        VStack {
            getPieChart()
            getLegend()
        }
    }
    
    func getPieChart() -> some View {
        PieChart(chartData: chartData, chartColors: dataColors, font: percentFont, percentColor: percentColor, circlet: circlet, centerText: centerText, centerColor: centerColor, centerTextColor: centerTextColor, centerTextFont: centerTextFont)
    }
    
    func getLegend() -> some View {
        Legend(items: dataColors, title: legendTitle, withBorder: withBorder, width: legendWidth, font: legendFont, cubeSize: cubeSize, borderWidth: borderWidth, borderColor: borderColor)
    }
}

struct PieChartWithLegend_Previews: PreviewProvider {
    static let data = ["Personal": 400.0, "Business": 300.0, "Others": 300.0]
    static var previews: some View {
        VStack {
            PieChartWithLegend(chartData: data, legendWidth: 100, circlet: true, centerText: "$\(total, specifier: "%.2f")", centerColor: .white, cubeSize: CGSize(width: 10, height: 10)).padding(5)
        }
    }
    static var total: Double {
        var total = 0.0
        for each in data.values {
            total += each
        }
        return total
    }
}
