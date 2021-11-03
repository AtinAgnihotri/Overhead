//
//  Card.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 04/11/21.
//

import SwiftUI

protocol ContainerView: View {
    associatedtype Content
    init(content: @escaping () -> Content)
}

extension ContainerView {
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.init(content: content)
    }
}

struct Card<Content: View>: ContainerView {
//    @Environment(\.colorScheme) var colorScheme
    var content: () -> Content
//
//    private var backgroundColor : {
//
//    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                content()
                Spacer()
            }
                .padding()
                .background(Color(UIColor.systemBackground))
                .clipped()
                .frame(width: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .shadow(color: .gray, radius: 5, x: 1, y: 1)
    }
}


struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            Text("This will be a card")
        }.preferredColorScheme(.light)
//        ContentView().environment(\.managedObjectContext, PersistenceManager.preview.container.viewContext)
    }
}
