//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Thomas Kellough on 7/12/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            // There is NOTHING behind a text view, so the color doesn't change
            // You need to set the frame to inifity so it has the OPTION to take up the entire space
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
