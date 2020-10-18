//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Thomas Kellough on 10/13/20.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink(
                    destination: CheckoutView(order: order),
                    label: {
                        Text("Check Out")
                    })
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Deliver Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
