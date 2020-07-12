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
    // Views can also be created as properites
    let textPropertyOne = Text("Draco Dormiens")
    
    var body: some View {
        VStack {
            textPropertyOne
                .foregroundColor(.purple)
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
                // Child modifier
                .font(.callout)
                .blur(radius: 0)
            
        }
            // Modifers can be applied to containers. This is called an Environment Modifier.
            // However, child modifiers will always take priority
            .font(.title)
            // Blur effect is different. It is a regular modifier so childviews are actually added to the VStack
            .blur(radius: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
