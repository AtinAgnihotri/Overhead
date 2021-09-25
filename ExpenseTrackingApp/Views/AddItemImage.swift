//
//  AddItemImage.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI

//struct AddNavBarButton: View {
//    var addAction: () -> Void
//
//    var body: some View {
//        Button(action: addAction, label: {
//            Image(systemName: "plus.app")
//                .font(.title2)
//        })
//    }
//}

//struct AddNavBarButton: View {
//    var addAction: () -> Void
//    
//    var body: some View {
//        Button(action: addAction, label: {
//            Image(systemName: "plus.app")
//                .font(.title2)
//        })
//    }
//}

struct TrailingNavBarButtons: View {
    var body: some View {
        Image(systemName: "plus")
            .foregroundColor(.primary)
            .frame(width: 50, height: 50, alignment: .trailing)
            .imageScale(.large)
            .scaleEffect(2)
            .padding()
    }
}

//struct AddItemImage_Previews: PreviewProvider {
//    static var previews: some View {
//        AddItemImage()
//    }
//}

