//
//  ContentView.swift
//  Animations
//
//  Created by Thomas Kellough on 8/24/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        Animation.easeOut(duration: 1)
                            .repeatForever(autoreverses: false)
                )
            )
                .onAppear {
                    self.animationAmount = 2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
