//
//  LegendItem.swift
//  SwiftUIScratchPad
//
//  Created by Atin Agnihotri on 27/07/21.
//

import SwiftUI

struct LegendItem: View {
    
    let item: String
    let color: Color
    let font: Font
    let cubeSize: CGSize
    
    init(item: String, color: Color, font: Font = .caption, size cubeSize: CGSize = Constants.Views.Legend.defaultSize) {
        self.item = item
        self.color = color
        self.font = font
        self.cubeSize = cubeSize
    }
    
    var body: some View {
        HStack {
            Rectangle()
                .stroke(Color.primary)
                .background(color)
                .frame(width: cubeSize.width, height: cubeSize.height, alignment: .center)
            Text(item)
                .font(font)
        }.frame(alignment: .trailing)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        LegendItem(item: "Personal", color: .red)
    }
}
