//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Juliette Rapala on 10/26/20.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
