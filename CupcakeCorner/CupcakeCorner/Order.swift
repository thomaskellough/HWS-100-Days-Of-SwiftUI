//
//  Order.swift
//  CupcakeCorner
//
//  Created by Thomas Kellough on 9/27/20.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
