//
//  TypeManager.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 18/07/21.
//

import Foundation

struct TypeManager {
    static let shared = TypeManager()
    
    let types = ["Personal", "Business"]
    
    private init () {
        
    }
}
