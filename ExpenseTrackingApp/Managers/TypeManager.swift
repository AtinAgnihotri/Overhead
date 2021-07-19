//
//  TypeManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 18/07/21.
//

import Foundation
import SwiftUI

struct TypeManager {
    static let shared = TypeManager()
    
    let typeData: Dictionary<String, Color> = ["Personal": .red, "Business": .blue]
    
    var types: [String] {
        Array(typeData.keys)
    }
    
    func typeColor(_ type: String) -> Color {
        return typeData[type] ?? .orange
    }
    
    private init () {
        
    }
}
