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
        
        UITableView.appearance().separatorStyle = .singleLine
        UITableView.appearance().separatorColor = .black
        UITableView.appearance().separatorInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
    }
    
    func setBaseTitleAppearance() {
//        if let orgLargeTitleFont = UINavigationBar.appearance().largeTitleTextAttributes?[.font] as? UIFont,
//           var orgTitleFont = UINavigationBar.appearance().titleTextAttributes?[.font] as? UIFont {
//            let largeTitleFont = UIFont(name: orgLargeTitleFont.fontName, size: 64)
//            let appearance = UINavigationBarAppearance()
//            appearance.largeTitleTextAttributes = [.font: largeTitleFont]
//            appearance.titleTextAttributes = [.font: orgTitleFont]
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().barTintColor = .clear
//
//            print("Reaches here")
//        }
        
//        let appearance = UINavigationBarAppearance()
//        appearance.largeTitleTextAttributes = [
////////            .font : UIFont.systemFont(ofSize: 100),
////////            .font : UIFont.systemFont(ofSize: 30, weight: .black),
//            .font : UIFont.boldSystemFont(ofSize: 44)
//////
//        ]
////        appearance.titleTextAttributes = [
////            .font : UIFont.systemFont(ofSize: 22, weight: .semibold),
////        ]
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().tintColor = .clear
//        UINavigationBar.appearance().barTintColor = .clear
//        print("Style Applied")
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: 100)]
        
    }
}


