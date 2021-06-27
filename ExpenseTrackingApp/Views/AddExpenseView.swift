//
//  AddExpenseView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var expenseManager = ExpenseManager.getInstance()
    let expenseTypes = ["Personal", "Business"]
    
    @State private var expenseAmount = ""
    @State private var expenseName = ""
    @State private var expenseType = "Personal"
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Name of the expense")
                                .font(.headline)) {
                        TextField("Name", text: $expenseName)
                    }
                    Section (header: Text("Amount spent")
                                .font(.headline)) {
                        TextField("Amount", text: $expenseAmount)
                            .keyboardType(.decimalPad)
                    }
                    Section (header: Text("Type of Expense")
                                .font(.headline)) {
                        Picker ("Type", selection: $expenseType){
                            ForEach(expenseTypes, id:\.self) {
                                Text("\($0)")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    CenteredFormButton(text: "ADD", backgroundColor: Color.green) {
                        addExpense()
                    }
                    CenteredFormButton(text: "DISMISS", backgroundColor: Color.red) {
                        dismissView()
                    }
                }
            }.navigationBarTitle("Add Expanse")
        }.transition(.scale)
    }
    
    
    func addExpense() {
        addNewExpenseItem(amount)
        dismissView()
    }
    
    func addNewExpenseItem(_ amount: Double) {
        let expense = ExpenseItem(name: expenseName, amount: amount, type: expenseType)
        expenseManager.expenseList.append(expense)
    }
    
    func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
