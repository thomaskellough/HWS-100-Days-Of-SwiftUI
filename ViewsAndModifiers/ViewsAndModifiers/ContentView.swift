//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Thomas Kellough on 7/12/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var useRedText = false
    
    var body: some View {
        VStack {
            Button("Hello, SwiftUI") {
                self.useRedText.toggle()
            }
            .foregroundColor(useRedText ? .red : .blue)
            
            Text("Hello, World!")
                // There is NOTHING behind a text view, so the color doesn't change
                // You need to set the frame to inifity so it has the OPTION to take up the entire space
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .edgesIgnoringSafeArea(.all)
            
            // Order matters!!!
            // In order to fill a bg color inside the frame, the frame must be created first
            Button("Hello World") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200)
            .background(Color.purple)
            
            Text("Hello with padding")
                .background(Color.red)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)
                .padding()
                .background(Color.blue)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
