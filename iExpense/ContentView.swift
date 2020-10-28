//
//  ContentView.swift
//  iExpense
//
//  Created by Juliette Rapala on 10/19/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                // No id property necessary if it has an id property
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(item.amount < 10 ? .black : item.amount < 100 ? Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)) : .red)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: expenses.items.count > 0 ? EditButton() : nil, trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        // 1. Attempt to read "Items" key from UserDefaults
        if let items = UserDefaults.standard.data(forKey: "Items") {
            // 2. Create instance of JSONDecoder
            let decoder = JSONDecoder()
            // 3. Ask the decoder to convert the data into an array of ExpenseItem objects
            // [ExpenseItem].self is referring to the type itself
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                // 4. If successful, assign array to items and exit
                self.items = decoded
                return
            }
        }
        // 5. Otherwise, set to be an empty array
        self.items = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
