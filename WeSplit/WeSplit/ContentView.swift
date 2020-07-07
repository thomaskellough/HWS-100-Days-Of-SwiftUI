//
//  ContentView.swift
//  WeSplit
//
//  Created by Thomas Kellough on 7/7/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // We are in a struct, so we can't edit values since they are immutable. Adding the @State property wrapper allows us to bypass this.
    // @State is specifically designed for small properties that are stored in one view
    // This means we should also add private properties
    @State private var tapCount = 0
    
    // When creating a textfield you need a string to store the value in
    @State private var name = ""
    
    var body: some View {
        // Add a navigation bar
        NavigationView {
            Form {
                Button("Tap Count \(tapCount)") {
                    self.tapCount += 1
                }
                // We need to create a binding so as the textfield gets updated, so does the variable
                // This is done using a $ before the variable name
                TextField("Entery your name", text: $name)
                // Notice we do NOT use $ in the Text(). We do not want a two-way binding
                // We want to read the value, but not write it back
                Text("Your name is \(name)")
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
