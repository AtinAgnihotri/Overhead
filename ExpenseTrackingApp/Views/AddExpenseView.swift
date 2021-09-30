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
    @ObservedObject var addExpenseVM = AddExpenseViewModel()
    @ObservedObject var keyboardUtil = KeyboardUtils()
    
    @State private var tableView: UITableView?
    @State private var textView: UITextView?
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var formAppeared = false

    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var noteRect: CGRect?
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section (header: Text("Name of the expense")
                                .font(.headline)) {
                        ResponsiveTextFeild(title: "Name", text: $addExpenseVM.name)
                            .introspectTextField{ textField in
                                if formAppeared {
                                    textField.becomeFirstResponder()
                                    formAppeared.toggle()
                                }
                            }
                    }
                    Section (header: Text("Amount spent")
                                .font(.headline)) {
                        ResponsiveTextFeild(title: "Amount", text: $addExpenseVM.amount)
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
                    Section (header: Text("Type of Expense")
                                .font(.headline)) {
                        TextEditor(text: $addExpenseVM.note)
                            .introspectTextView { textView in
                                self.textView = textView
                            }
                            .onChange(of: addExpenseVM.note) { _ in
                                keyboardUtil.scrollWhenKeyboard(isShowing: true, for: tableView)

                            }
                            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                                    keyboardUtil.scrollWhenKeyboard(isShowing: false, for: tableView)
                                }
                            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                                    if let textView = textView,
                                       textView.isFirstResponder {
                                        keyboardUtil.scrollWhenKeyboard(isShowing: true, for: tableView)
                                    }
                                }
                    }
                }
                .introspectTableView { tableView in
                    self.tableView = tableView
                }
            }
            .navigationBarTitle("Add Expanse")
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
        }
        .transition(.scale)
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
        addExpenseVM.addExpense(completion: dismissView, onFail: showError)
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
