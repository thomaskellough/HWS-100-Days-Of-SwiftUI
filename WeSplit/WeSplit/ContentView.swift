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
    
    // Constants do NOT need to be marked with @State
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedSutdent = "Harry"
    
    var body: some View {
        // Add a navigation bar
        NavigationView {
            Form {
                
                Picker("Select your student", selection: $selectedSutdent) {
                    ForEach(0 ..< students.count) {
                        Text(self.students[$0])
                    }
                }
                
                Button("Tap Count \(tapCount)") {
                    self.tapCount += 1
                }
                // We need to create a binding so as the textfield gets updated, so does the variable
                // This is done using a $ before the variable name
                TextField("Entery your name", text: $name)
                // Notice we do NOT use $ in the Text(). We do not want a two-way binding
                // We want to read the value, but not write it back
                Text("Your name is \(name)")
                
                // Creating rows using loops
                ForEach(0 ..< 100) {
                    Text("Row \($0)")
                }
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
