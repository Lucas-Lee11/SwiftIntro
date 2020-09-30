//
//  AddView.swift
//  iExpense
//
//  Created by Lucas Lee on 9/28/20.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State var name:String = ""
    @State var type:String = "Personal"
    @State var amount:String = ""
    @State var errorAlert:Bool = false

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
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount:Int = Int(self.amount) {
                    let item:ExpenseItem = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item) //Shared with ContentView
                    self.presentationMode.wrappedValue.dismiss()
                }
                else{
                    self.errorAlert.toggle()
                }
            })
            .alert(isPresented: $errorAlert) {
                Alert(title: Text("Enter a number"), message: Text("\(self.amount) is not a number"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
