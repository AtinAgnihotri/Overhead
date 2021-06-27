//
//  CenteredFormButton.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI

struct CenteredFormButton: View {
    var text: String
    var backgroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(text) {
            action()
        }.padding()
        .centerItemInForm()
        .font(.headline)
        .background(backgroundColor)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CenteredFormButtons_Previews: PreviewProvider {
    static var previews: some View {
        CenteredFormButton(text: "Hello", backgroundColor: Color.red) {
            print("Hello")
        }
    }
}
