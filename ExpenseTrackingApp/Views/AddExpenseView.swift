//
//  AddExpenseView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 27/06/21.
//

import SwiftUI
import Introspect
import Combine

struct AddExpenseView: View {
    @ObservedObject var expenseListVM = ExpenseListViewModel.getInstance()
    @ObservedObject var addExpenseVM = AddExpenseViewModel()
//    let expenseTypes = TypeManager.shared.types
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    @State private var formAppeared = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Name of the expense")
                                .font(.headline)) {
                        TextField("Name", text: $addExpenseVM.name)
                            .introspectTextField{ textField in
                                if formAppeared {
                                    textField.becomeFirstResponder()
                                    formAppeared.toggle()
                                }
                            }
                    }
                    Section (header: Text("Amount spent")
                                .font(.headline)) {
                        TextField("Amount", text: $addExpenseVM.amount)
                            .keyboardType(.decimalPad)
                    }
                    Section (header: Text("Type of Expense")
                                .font(.headline)) {
                        Picker ("Type", selection: $addExpenseVM.type){
                            ForEach(addExpenseVM.types, id:\.self) {
                                Text("\($0.rawValue)")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
            }.navigationBarTitle("Add Expanse")
            .navigationBarItems(leading: Button(action: dismissView) {
                                    Text("Cancel").foregroundColor(.red)
                                },
                                trailing: Button(action: addExpense) {
                                    Text("Save")
                                        .fontWeight(.bold)
                                })
            .tertiaryBackground()
            .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
            }
        }.transition(.scale)
        .onAppear {
            formAppeared = true
        }
    }
    
    func showError(alertTitle: String, alertMsg: String) {
        self.alertTitle = alertTitle
        self.alertMsg = alertMsg
        self.showingAlert = true
    }
    
    func addExpense() {
        addExpenseVM.addExpense(to: expenseListVM, onFail: showError, completion: dismissView)
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
