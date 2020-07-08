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
        ZStack {
            // Color needs to be placed first to fill bg
            Color.green.edgesIgnoringSafeArea(.all)
            Color(red:1, green: 0.8, blue: 0.3)
            Color.red.frame(width: 250, height: 250)
            Text("Your content")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
