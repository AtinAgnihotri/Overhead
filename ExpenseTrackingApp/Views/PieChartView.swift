//
//  PieChartView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 18/07/21.
//

import SwiftUI

struct PieceOfPie: Shape {
    let startDegree: Double
    let endDegree: Double
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = rect.width / 2
            p.move(to: center)
            p.addArc(center: center,
                     radius: radius,
                     startAngle: Angle(degrees: startDegree),
                     endAngle: Angle(degrees: endDegree),
                     clockwise: false)
            p.closeSubpath()
        }
    }
}

struct PieChartView: View {
    let chartData: Dictionary<String, Double>
    var dataKeys: [String] {
        Array(chartData.keys)
    }
    let colors: [Color] = [.red, .blue, .gray, .green, .orange, .pink, .purple, .yellow]
    @State var lastColor: Color = .gray
    @State var lastDegree = 0.0
    @State var count = 0
    
    @State var activeIndex = -1
    
    init(chartData: Dictionary<String, Double>) {
        let total = Array(chartData.values).reduce(0, +)
        var percentageData = chartData
        for key in percentageData.keys {
            percentageData[key] = percentageData[key]! / total
        }
        self.chartData = percentageData
    }
    
    var body: some View {
        ZStack {
            ForEach(dataKeys, id:\.self) { key in
                ZStack {
                    PieceOfPie(startDegree: getStartDegree(key),
                               endDegree: getStartDegree(key) + getEndDegree(key))
                        .foregroundColor(TypeManager.shared.colorType(key))
                        .scaleEffect(self.activeIndex == dataKeys.firstIndex(of: key) ? 1.03 : 1)
                        .onHover(perform: { hovering in
                            if hovering {
                                self.activeIndex = dataKeys.firstIndex(of: key)!
                            } else {
                                self.activeIndex = -1
                            }
                        })
                        
                    GeometryReader { geo in
                        Text("\(key): \(getRoundedPercentage(key), specifier: "%g")%")
                            .font(.caption)
                            .foregroundColor(.primary)
                            .position(getLabelCoordinate(in: geo.size,
                                                         for: getStartDegree(key) + getEndDegree(key)/2))
                    }
                }
            }
        }.shadow(radius: 5)
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
        let radius = geo.width / 4
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

struct PieChartView_Previews: PreviewProvider {
    static let data = ["Personal": 0.4, "Business": 0.3, "Others": 0.3]
    static var previews: some View {
        VStack {
            PieChartView(chartData: data).padding()
        }
    }
}
