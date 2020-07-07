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
    
    var body: some View {
        // Add a navigation bar
        NavigationView {
            Button("Tap Count \(tapCount)") {
                self.tapCount += 1
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
