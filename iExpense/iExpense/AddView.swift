//
//  AddView.swift
//  iExpense
//
//  Created by Thomas Kellough on 9/3/20.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingInvalidAmountAlert = false
    
    @ObservedObject var expenses: Expenses
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .alert(isPresented: $showingInvalidAmountAlert) {
                Alert(title: Text("Error"), message: Text("Please enter an integer only"), dismissButton: .default(Text("Okay!")))
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingInvalidAmountAlert.toggle()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
