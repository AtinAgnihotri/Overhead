//
//  Legend.swift
//  SwiftUIScratchPad
//
//  Created by Atin Agnihotri on 27/07/21.
//

import SwiftUI

struct Legend: View {
    let legendTitle: String
    let legendItems: [String: Color]
    let withBorder: Bool
    let legendWidth: CGFloat
    let font: Font
    let cubeSize: CGSize
    let borderWidth: CGFloat
    let borderColor: Color
    
    
    var legendKeys: [String] {
        Array(legendItems.keys)
    }
    
    init(items legendItems: [String: Color],
         title legendTitle: String = "Legend",
         withBorder: Bool = true,
         width legendWidth: CGFloat = .infinity,
         font: Font = .caption,
         cubeSize: CGSize = CGSize(width: 20, height: 20),
         borderWidth: CGFloat = 1,
         borderColor: Color = .primary) {
        self.legendTitle = legendTitle
        self.legendItems = legendItems
        self.withBorder = withBorder
        self.legendWidth = legendWidth
        self.font = font
        self.cubeSize = cubeSize
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
    
    var body: some View {
        if withBorder {
            getBorderedLegend()
        } else {
            getLegend()
        }
    }
    
    func getBorderedLegend() -> some View {
        getLegend()
            .border(borderColor, width: borderWidth)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .shadow(radius: 5)
            .padding(5)
            .frame(width: legendWidth, alignment: .trailing)
    }
    
    func getLegend() -> some View{
        VStack {
            Text("Legend")
                .font(font)
                .frame(alignment: .leading)
            ForEach(legendKeys, id:\.self) { key in
                HStack {
                    LegendItem(item: key, color: legendItems[key] ?? .black, font: font, size: cubeSize)
                        .frame( alignment: .leading)
                    Spacer(minLength: 0.1)
                }
            }.frame(alignment: .leading)
        }
        .padding(5)
        .clipShape(RoundedRectangle(cornerRadius: 2))
        .shadow(radius: 5)
        .padding(5)
        .frame(width: legendWidth, alignment: .trailing)
    }
}

struct Legend_Previews: PreviewProvider {
    static let items = [
        "Personal": Color.red,
        "Business": Color.green,
        "Others": Color.orange
    ]
    static var previews: some View {
        Legend(items: items, width: 118)
    }
}
