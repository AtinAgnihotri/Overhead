//
//  LegendView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 19/07/21.
//

import SwiftUI

struct PieChartLegend: View {
    
    let type: String
//    var spacer: Bool = false
    var color: Color {
        TypeManager.shared.typeColor(type)
    }
    
    var body: some View {
        HStack {
            Rectangle()
                .stroke(Color.primary)
                .background(color)
                .frame(width: 20, height: 20, alignment: .center)
            Text(type)
        }.frame(alignment: .trailing)
    }
}

struct LegendView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartLegend(type: "Personal")
    }
}
