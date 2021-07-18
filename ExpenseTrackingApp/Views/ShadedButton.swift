//
//  ShadedButotn.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 18/07/21.
//

import SwiftUI

struct ShadedButton: View {
    var text: String
    var backgroundColor: Color
    var foregroundColor: Color = .white
    var gradientColor: Color
    var action: () -> Void
    
    init(text: String,
        foregroundColor: Color = .white,
        backgroundColor: Color = .orange,
        gradientColor: Color = .black,
        action: @escaping () -> Void = {}) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.gradientColor = gradientColor
        self.action = action
    }
    
    var body: some View {
        Button(text) {
            action()
        }.frame(maxWidth: .infinity)
        .padding()
        .font(.headline)
        .background(LinearGradient(gradient: Gradient(colors: [backgroundColor, gradientColor]), startPoint: .top, endPoint: .bottom))
        .foregroundColor(foregroundColor)
        .shadow(radius: 5)
    }
}

struct ShadedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ShadedButton(text: "Sample Button")
                .clipShape(Capsule())
//                .padding()
        }
    }
}
