//
//  ContentView.swift
//  HotProspects
//
//  Created by Thomas Kellough on 11/29/20.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu(ContextMenu(menuItems: {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "bolt")
                    }
                    Button("Green") {
                        self.backgroundColor = .green
                    }
                    Button("Blue") {
                        self.backgroundColor = .blue
                    }
                }))
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
