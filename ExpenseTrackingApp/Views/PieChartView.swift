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
    
    var body: some View {
        ZStack {
//            ForEach(dataKeys, id:\.self) { key in
            ForEach(0..<dataKeys.count) { index in
                ZStack {
                    PieceOfPie(startDegree: getStartDegree(index),
                               endDegree: getEndDegree(index))
                        .foregroundColor(newColor())
//                    Text("S: \(getStartDegree(index), specifier: "%.2f"), E: \(getEndDegree(index), specifier: "%.2f")")
                }
            }
        }
    }
    
    func getStartDegree(_ index: Int) -> Double {
        if index == 0 { return 0 }
        else  {
            return chartData[dataKeys[index - 1]]! * 360
        }
    }
    
    func getEndDegree(_ index: Int) -> Double {
        if index == dataKeys.count - 1 { return 360 }
        return chartData[dataKeys[index]]! * 360
    }
    
    func newColor() -> Color {
        var newColor = colors.randomElement()
        while lastColor == newColor {
            newColor = colors.randomElement()
        }
        lastColor = newColor!
        return newColor!
    }
}

struct PieChartView_Previews: PreviewProvider {
    static let data = ["Personal": 0.5, "Business": 0.5]
    static var previews: some View {
        VStack {
            PieChartView(chartData: data)
        }
    }
}
