//
//  DetailedExpenseView.swift
//  ExpenseTrackingApp
//
//  Created by Atin Agnihotri on 28/06/21.
//

import SwiftUI

enum DetailedExpenseAlertTypes {
    case validation
    case confirmation
}

struct DetailedExpenseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var detailedExpenseVM: DetailedExpenseViewModel
    @ObservedObject var keyboardUtil = KeyboardUtils()
    
    @State private var alertTitle: String = ""
    @State private var alertMsg: String = ""
    @State private var alertType: DetailedExpenseAlertTypes = .validation
    @State private var isShowingAlert: Bool = false
    @State private var tableView: UITableView?
    @State private var textView: UITextView?
    
    var expenseVM: ExpenseItemViewModel

    var formattedDate: String {
        "Date: \(formatDate: expenseVM.date)"
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
    
    
    init(_ expenseVM: ExpenseItemViewModel) {
        self.expenseVM = expenseVM
        self.detailedExpenseVM = DetailedExpenseViewModel(with: expenseVM)
    }
    
    var body: some View {
        Form {
            if isEditing {
                HStack {
                    Text("Name:")
                    TextField("Enter Name", text: $detailedExpenseVM.name)
                        .introspectTextField { textField in
                            textField.textAlignment = .right
                            textField.contentHorizontalAlignment = .right
                        }
                        .padding(Constants.Views.basePadding)
                        .background(
                            RoundedRectangle(cornerRadius: Constants.Views.basePadding)
                                .foregroundColor(Color(UIColor.secondarySystemFill))
                        )
                }.secondaryListBackground()
            }
            HStack {
                Text("Amount:")
                if isEditing {
                TextField("Enter Amount", text: $detailedExpenseVM.amount)
                    .keyboardType(.decimalPad)
                    .disabled(!detailedExpenseVM.isEditing)
                    .introspectTextField { textField in
                        textField.textAlignment = .right
                        textField.contentHorizontalAlignment = .right
                    }
                    .padding(Constants.Views.basePadding)
                    .background(
                        RoundedRectangle(cornerRadius: Constants.Views.basePadding)
                            .foregroundColor(Color(UIColor.secondarySystemFill))
                    )
                    
                } else {
                    Spacer()
                    Text(detailedExpenseVM.amount)
                }
            }.secondaryListBackground()
            HStack {
                Text("Type:")
                if detailedExpenseVM.isEditing {
                    Picker ("", selection: $detailedExpenseVM.type){
                        ForEach(ExpenseType.allCases, id:\.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .foregroundColor(.blue)
                } else {
                    Spacer()
                    Text(detailedExpenseVM.type.rawValue)
                }
            }.secondaryListBackground()
            HStack {
                Text("Date:")
                Spacer()
                Text(detailedExpenseVM.date)
            }.secondaryListBackground()
            if showNote {
                Section (header: Text("Note")) {
                    TextEditor(text: $detailedExpenseVM.note)
                        .introspectTextView { textView in
                            self.textView = textView
                        }
                        .onChange(of: detailedExpenseVM.note) { _ in
                            keyboardUtil.scrollWhenKeyboard(for: tableView)
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                                keyboardUtil.scrollWhenKeyboard(for: tableView)
                            }
                        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                                if let textView = textView,
                                   textView.isFirstResponder {
                                    keyboardUtil.scrollWhenKeyboard(for: tableView)
                                }
                            }
                        .disabled(!isEditing)
                }.secondaryListBackground()
            }
        }
        .introspectTableView { tableView in
            self.tableView = tableView
        }
        .navigationBarTitle(expenseVM.name)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: BackNavBarButton(action: dismissView),
            trailing: HStack {
                if detailedExpenseVM.isEditing {
                    CrossNavBarButton(action: discardChanges).padding()
                    TickNavBarButton(action: saveChanges)
                } else {
                    DeleteNavBarButton(action: confirmDeletion).padding()
                    EditNavBarButton(action: didStartEditing)
                }
        })
        .clearBackground()
        .alert(isPresented: $isShowingAlert, content: {
            switch alertType {
                case .validation :
                    return getValidationErrorAlert()
                case .confirmation:
                    return getDeletionConfirmationAlert()
            }
        })
    }
    
    func dismissView() {
        didFinishEditing()
        self.presentationMode.wrappedValue.dismiss()
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
        detailedExpenseVM.saveChanges(onFail: showValidationError)
        didFinishEditing()
    }
    
    func showValidationError(title: String, message: String) {
        showAlert(title: title, message: message, type: .validation)
    }
    
    func confirmDeletion() {
        showAlert(title: "Confirm Deletion", message: "Are you sure you want to delete this expense?", type: .confirmation)
    }
    
    func showAlert(title: String, message: String, type: DetailedExpenseAlertTypes) {
        alertTitle = title
        alertMsg = message
        alertType = type
        isShowingAlert = true
    }
    
    func getValidationErrorAlert() -> Alert {
        Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
    }
    
    func getDeletionConfirmationAlert() -> Alert {
        Alert(title: Text(alertTitle),
              message: Text(alertMsg),
              primaryButton: .destructive(Text("Confirm"), action: delete),
              secondaryButton: .cancel())
    }
    
    func delete() {
        detailedExpenseVM.deleteItem {
            dismissView()
        }
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
