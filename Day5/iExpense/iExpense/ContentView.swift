//
//  ContentView.swift
//  iExpense
//
//  Created by Lucas Lee on 9/28/20.
//

import SwiftUI

struct ExpenseItem:Identifiable, Codable {
    let name: String
    let type: String
    let amount: Int
    let id:UUID = UUID()
}

class Expenses: ObservableObject {
    @Published var items:[ExpenseItem] = [ExpenseItem](){
        didSet {
            let encoder:JSONEncoder = JSONEncoder()
            if let encoded:Data = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items:Data = UserDefaults.standard.data(forKey: "Items") {
            let decoder:JSONDecoder = JSONDecoder()
            if let decoded:[ExpenseItem] = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses:Expenses = Expenses()
    @State var showingAddExpense:Bool = false
    
    func removeItems(at offsets: IndexSet) -> Void{
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text("$\(item.amount)").foregroundColor(item.amount >= 100 ? .red : .black)
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
