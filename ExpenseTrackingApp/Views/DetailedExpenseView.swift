//
//  DetailedExpenseView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 28/06/21.
//

import SwiftUI

struct DetailedExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var detailedExpenseVM: DetailedExpenseViewModel
    @State private var alertTitle: String = ""
    @State private var alertMsg: String = ""
    @State private var isShowingAlert: Bool = false
    
    var expenseVM: ExpenseItemViewModel

    var formattedDate: String {
        "Date: \(formatDate: expenseVM.date)"
    }
    
    
    init(_ expenseVM: ExpenseItemViewModel) {
        self.expenseVM = expenseVM
        self.detailedExpenseVM = DetailedExpenseViewModel(with: expenseVM)
    }
    
    var isEditing: Bool {
        detailedExpenseVM.isEditing
    }
    
    var hasNote: Bool {
        !detailedExpenseVM.note.isEmpty
    }
    
    var showNote: Bool {
        isEditing || hasNote
    }
    
    var body: some View {
        Form {
            HStack {
                Text("Amount:")
                if isEditing {
                TextField("Enter Amount", text: $detailedExpenseVM.amount)
                    .disabled(!detailedExpenseVM.isEditing)
                    .introspectTextField { textField in
                        textField.textAlignment = .right
                    }
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(UIColor.secondarySystemFill))
                    )
                    
                } else {
                    Spacer()
                    Text(detailedExpenseVM.amount)
                }
            }
            HStack {
                Text("Type:")
                if detailedExpenseVM.isEditing {
                    Picker ("", selection: $detailedExpenseVM.type){
                        ForEach(ExpenseType.allCases, id:\.self) {
                            Text("\($0.rawValue)")
                        }
                    }.foregroundColor(.blue)
                } else {
                    Spacer()
                    Text(detailedExpenseVM.type.rawValue)
                }
            }
            HStack {
                Text("Date:")
                Spacer()
                Text(detailedExpenseVM.date)
            }
            if showNote {
                Section (header: Text("Note")) {
                    TextEditor(text: $detailedExpenseVM.note)
                        .disabled(!isEditing)
                }
            }
            

        }.navigationBarTitle(expenseVM.name)
        .navigationBarItems(trailing: HStack {
            if detailedExpenseVM.isEditing {
                CrossNavBarButton(action: discardChanges).padding()
                TickNavBarButton(action: saveChanges)
            } else {
                DeleteNavBarButton(action: deleteItem).padding()
                EditNavBarButton(action: didStartEditing)
            }
        })
        .clearBackground()
        .alert(isPresented: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is Presented@*/.constant(false)/*@END_MENU_TOKEN@*/, content: {
            Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
        })
    }
    
    func dismissView() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func deleteItem() {
        
    }
    
    func didStartEditing() {
        detailedExpenseVM.isEditing = true
    }
    
    func didFinishEditing() {
        detailedExpenseVM.isEditing = false
    }
    
    func discardChanges() {
        didFinishEditing()
    }
    
    func saveChanges() {
        detailedExpenseVM.saveChanges(onFail: showAlert)
        didFinishEditing()
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMsg = message
        isShowingAlert = true
    }
}

struct DetailedExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = CDExpenseItem(context: PersistenceManager.viewContext)
        expense.name = "Test Expense"
        expense.amount = 1.22
        expense.date = Date()
        expense.type = "Personal"
        let expenseVM = ExpenseItemViewModel(expenseItem: expense)
        return DetailedExpenseView(expenseVM)
    }
}
