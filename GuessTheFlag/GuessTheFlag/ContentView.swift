//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Thomas Kellough on 7/7/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // VStack can only have 10 children, you can control with a group
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Hello world!")
                Text("Hello world!")
                Text("Hello world!")
            }
            HStack {
                Text("Hello world!")
                Text("Hello world!")
                Text("Hello world!")
            }
            HStack {
                Text("Hello world!")
                Text("Hello world!")
                Text("Hello world!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
