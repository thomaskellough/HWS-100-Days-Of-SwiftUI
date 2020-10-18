//
//  Order.swift
//  CupcakeCorner
//
//  Created by Thomas Kellough on 9/27/20.
//

import SwiftUI

class Order: ObservableObject {
    @Published var orderDetails: OrderDetails
    
    init(order: OrderDetails) {
        self.orderDetails = OrderDetails()
    }
}

struct OrderDetails: Codable {
    static let types = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
    
    // MARK: Order details
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    // MARK: Address details
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)

        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
