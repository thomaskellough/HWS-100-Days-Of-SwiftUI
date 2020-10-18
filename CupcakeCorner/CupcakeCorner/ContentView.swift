//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Thomas Kellough on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order: Order
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cupcake", selection: $order.orderDetails.type) {
                        ForEach(OrderDetails.types.indices) { index in
                            Text(OrderDetails.types[index])
                        }
                    }
                    
                    Stepper(value: $order.orderDetails.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.orderDetails.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.orderDetails.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.orderDetails.specialRequestEnabled {
                        Toggle(isOn: $order.orderDetails.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.orderDetails.addSprinkles) {
                            Text("Add sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: AddressView(order: order),
                        label: {
                            Text("Delivery Details")
                        })
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(order: Order(order: OrderDetails()))
    }
}
