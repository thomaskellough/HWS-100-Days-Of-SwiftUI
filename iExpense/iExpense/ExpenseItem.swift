//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Thomas Kellough on 9/3/20.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
