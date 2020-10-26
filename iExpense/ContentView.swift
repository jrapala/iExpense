//
//  ContentView.swift
//  iExpense
//
//  Created by Juliette Rapala on 10/19/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.name) { item in
                    Text(item.name)
                }
            }
            .navigationBarTitle("iExpense")
        }
    }
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
