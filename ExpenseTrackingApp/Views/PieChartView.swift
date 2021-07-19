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
    let total: Double
    var dataKeys: [String] {
        Array(chartData.keys)
    }
    let colors: [Color] = [.red, .blue, .gray, .green, .orange, .pink, .purple, .yellow]
    let largestCount: Int
    @State var lastColor: Color = .gray
    @State var lastDegree = 0.0
    @State var count = 0
    @State var activeIndex = -1
    
    init(chartData: Dictionary<String, Double>) {
        total = Array(chartData.values).reduce(0, +)
        var percentageData = chartData
        var largestCount = 0
        for key in percentageData.keys {
            percentageData[key] = percentageData[key]! / total
            if key.count > largestCount { largestCount = key.count}
        }
        self.largestCount = largestCount
        self.chartData = percentageData
    }
    
    var body: some View {
        HStack {
            ZStack {
                ForEach(dataKeys, id:\.self) { key in
                    ZStack {
                        PieceOfPie(startDegree: getStartDegree(key),
                                   endDegree: getStartDegree(key) + getEndDegree(key))
                            .foregroundColor(TypeManager.shared.typeColor(key))
                            
                        GeometryReader { geo in
                            Text("\(getRoundedPercentage(key), specifier: "%g")%")
                                .font(.caption)
                                .foregroundColor(.white)
                                .position(getLabelCoordinate(in: geo.size,
                                                             for: getStartDegree(key) + getEndDegree(key)/2))
                        }
                    }
                }
                Circle()
                    .foregroundColor(.primary)
                    .colorInvert()
                    .scaleEffect(0.55)
                Text("$\(total, specifier: "%.2f")")
                    .font(.caption)
                    .foregroundColor(.primary)
                
            }.shadow(radius: 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                    Text("Legend")
                        .font(.headline)
                        .frame(alignment: .leading)
                    ForEach(dataKeys, id:\.self) { key in
                        HStack {
                            PieChartLegend(type: key).frame( alignment: .leading)
                            Spacer(minLength: 0.1)
                        }
                    }.frame(alignment: .leading)
            }
            .padding(5)
            .border(Color.primary, width: 1)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .shadow(radius: 5)
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
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

struct PieChartView_Previews: PreviewProvider {
    static let data = ["Personal": 400.0, "Business": 300.0, "Others": 300.0]
    static var previews: some View {
        VStack {
            PieChartView(chartData: data)
        }
    }
}
