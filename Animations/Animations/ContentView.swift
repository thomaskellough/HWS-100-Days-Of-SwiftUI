//
//  ContentView.swift
//  Animations
//
//  Created by Thomas Kellough on 8/24/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        VStack {
            Button("Flip Y") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.animationAmount += 360
                }
            }
            .styleButton(color: Color.red)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            .padding()
            Button("Flip X") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.animationAmount += 360
                }
            }
            .styleButton(color: Color.blue)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
            .padding()
            Button("Flip Z") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.animationAmount += 360
                }
            }
            .styleButton(color: Color.green)
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 1))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Custom View Modifier

struct ButtonStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(50)
            .background(color)
            .foregroundColor(.white)
            .clipShape(Circle())
    }
}

extension View {
    func styleButton(color: Color) -> some View {
        self.modifier(ButtonStyle(color: color))
    }
}
