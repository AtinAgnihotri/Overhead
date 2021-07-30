//
//  PieceOfPie.swift
//  SwiftUIScratchPad
//
//  Created by Atin Agnihotri on 27/07/21.
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
