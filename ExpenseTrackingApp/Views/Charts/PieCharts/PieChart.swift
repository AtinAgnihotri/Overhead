//
//  PieChart.swift
//  SwiftUIScratchPad
//
//  Created by Atin Agnihotri on 27/07/21.
//

import SwiftUI

struct PieChart: View {
    let chartData: Dictionary<String, Double>
    let total: Double
    
    var dataKeys: [String] {
        Array(chartData.keys)
    }
    
    let percentFont: Font
    let percentColor: Color
    
    let circlet: Bool
    let centerText: LocalizedStringKey?
    let centerColor: Color
    let centerTextColor: Color
    let centerTextFont: Font
    let centerTextFontWeight: Font.Weight
    
    let chartColors: [String: Color]?
    
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
         chartColors: [String: Color]? = nil,
         font percentFont: Font = .caption,
         percentColor: Color = .white,
         circlet: Bool = false,
         centerText: LocalizedStringKey? = nil,
         centerColor: Color = Color(UIColor.tertiarySystemFill),
         centerTextColor: Color = .primary,
         centerTextFont: Font = .caption,
         centerTextFontWeight: Font.Weight = .regular) {
        total = Array(chartData.values).reduce(0, +)
        var percentageData = chartData
        for key in percentageData.keys {
            percentageData[key] = percentageData[key]! / total
        }
        self.chartData = percentageData
        self.chartColors = chartColors
        self.percentFont = percentFont
        self.percentColor = percentColor
        self.circlet = circlet
        self.centerText = centerText
        self.centerColor = centerColor
        self.centerTextColor = centerTextColor
        self.centerTextFont = centerTextFont
        self.centerTextFontWeight = centerTextFontWeight
    }
    
    var body: some View {
        ZStack {
            ForEach(dataKeys, id:\.self) { key in
                ZStack {
                    PieceOfPie(startDegree: getStartDegree(key),
                               endDegree: getStartDegree(key) + getEndDegree(key))
                        .foregroundColor(dataColors[key])
                        
                    GeometryReader { geo in
                        Text("\(getRoundedPercentage(key), specifier: "%g")%")
                            .font(percentFont)
                            .foregroundColor(percentColor)
                            .position(getLabelCoordinate(in: geo.size,
                                                         for: getStartDegree(key) + getEndDegree(key)/2))
                    }
                }
            }
            if circlet {
                Circle()
                    .foregroundColor(centerColor)
                    .background(Color.primary
                                    .colorInvert()
                                    .clipShape(Circle()))
                    .scaleEffect(0.55)
            }
            if let centerText = centerText {
                Text(centerText)
                    .font(centerTextFont)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(centerTextColor)
            }
        }
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func getTotal() -> Double {
        Array(chartData.values).reduce(0, +)
    }
    
    func getRoundedPercentage(_ key: String) -> Double {
        var value = chartData[key]!
        value *= 100
        value = round(value)
        return value
    }
    
    func getAlignment(_ key: String) -> Alignment {
        print("\(key), \(getStartDegree(key)), \(getEndDegree(key))")
        if key == "Personal" { return .leading }
        else if key == "Business" { return .trailing }
        else { return .center }
    }
    
    func getLabelCoordinate(in geo: CGSize, for degree: Double) -> CGPoint {
        let center = CGPoint(x: geo.width / 2, y: geo.height / 2)
        let radius = geo.width / 2.6
        let yCoordinate = radius * sin(CGFloat(degree) * (CGFloat.pi/180))
        let xCoordinate = radius * cos(CGFloat(degree) * (CGFloat.pi/180))
        return CGPoint(x: center.x + xCoordinate, y: center.y + yCoordinate)
    }
    
    func getStartDegree(_ key: String) -> Double {
        let index = dataKeys.firstIndex(of: key)!
        if index == 0 { return 0 }
        else  {
            var startDegree = 0.0
            for indx in 0..<index {
                startDegree += chartData[dataKeys[indx]]! * 360
            }
            return startDegree
        }
    }
    
    func getEndDegree(_ key: String) -> Double {
        let index = dataKeys.firstIndex(of: key)!
        return chartData[dataKeys[index]]! * 360
    }
}

struct PieChart_Previews: PreviewProvider {
    static let data = ["Personal": 400.0, "Business": 300.0, "Others": 300.0]
    static var previews: some View {
        VStack {
            PieChart(chartData: data, font: .headline).padding()
        }
    }
}
