//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Thomas Kellough on 9/27/20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cupcake", selection: $order.type) {
                        ForEach(Order.types.indices) { index in
                            Text(Order.types[index])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
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
        ContentView()
    }
}
