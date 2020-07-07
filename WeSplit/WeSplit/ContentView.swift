//
//  ContentView.swift
//  WeSplit
//
//  Created by Thomas Kellough on 7/7/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Add a navigation bar
        NavigationView {
            Form {
                // Limit of 10! After 10, use groups
                // You can also break it apart into sections
                Section {
                    Text("Hello, World!")
                    Text("Hello, Old World!")
                    Text("Hello, New World!")
                    Text("Hello, World!")
                    Text("Hello, Old World!")
                }
                Group {
                    Text("Hello, World!")
                    Text("Hello, Old World!")
                    Text("Hello, New World!")
                    Text("Hello, World!")
                    Text("Hello, Old World!")
                }
                Section {
                    Text("Hello, World!")
                    Text("Hello, Old World!")
                    Text("Hello, New World!")
                    Text("Hello, World!")
                    Text("Hello, Old World!")
                }
            }
//             Use modifiers to edit specific components
//            .navigationBarTitle(Text("SwiftUI"))
//             You can also use small titles by default
//                .navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
//            You can also just use a shortcut for both since it's so common
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
