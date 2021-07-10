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
            .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            }
        }.transition(.scale)
    }
    
    func showError(alertTitle: String, alertMsg: String) {
        self.alertTitle = alertTitle
        self.alertMsg = alertMsg
        self.showingAlert = true
    }
    
    func addExpense() {
        // Input Validations
        guard expenseName != "" else {
            showError(alertTitle: "Empty Name", alertMsg: "The name cannot be empty")
            return
        }
        guard let amount = Double(expenseAmount) else {
            showError(alertTitle: "Invalid Amount", alertMsg: "Please enter a valid amount")
            return
        }
        
        expenseManager.saveExpense(name: expenseName, type: expenseType, amount: amount)
        dismissView()
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
