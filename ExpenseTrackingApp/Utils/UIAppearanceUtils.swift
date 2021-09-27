//
//  UIAppearanceUtils.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 24/09/21.
//

import SwiftUI

class UIAppearanceUtils {
    static let shared = UIAppearanceUtils()
    
    private init() {
        
    }
    
    func setTableViewAppearance() {
        UITableViewCell.appearance().selectionStyle = .none
        UITableViewCell.appearance().accessoryType = .none
        UITableViewCell.appearance().accessoryView = .none
        
        
        if let cgColor = Color(UIColor.tertiarySystemFill).cgColor {
            UITableView.appearance().backgroundColor = UIColor(cgColor: cgColor)
        }
//        UITableView.appearance().backgroundColor = UIColor(cgColor: Color(UIColor.tertiarySystemFill).cgColor)
        
        UITableView.appearance().separatorStyle = .singleLine
        UITableView.appearance().separatorColor = .black
        UITableView.appearance().separatorInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
    }
}


