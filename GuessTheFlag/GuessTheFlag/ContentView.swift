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
        // Common to dedicate images into your button
        Button(action: {
            print("Button was tapped!")
        }) {
            HStack(spacing: 10) {
                Image(systemName: "pencil")
                    .renderingMode(.original)
                Text("Edit")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
