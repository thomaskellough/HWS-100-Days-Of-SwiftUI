//
//  ContentView.swift
//  Flashzilla
//
//  Created by Thomas Kellough on 12/13/20.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    @State private var scale: CGFloat = 1

    var body: some View {
        VStack {
            HStack {
                if differentiateWithoutColor {
                    Image(systemName: "checkmark.circle")
                }
                
                Text("Success")
            }
            .padding()
            .background(differentiateWithoutColor ? Color.black : Color.green)
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            Text("Hello, world")
                .scaleEffect(scale)
                .onTapGesture {
                    if self.reduceMotion {
                        self.scale += 1.5
                    } else {
                        withAnimation {
                            self.scale += 1.5
                        }
                    }
                }
                .padding()
            
            Text("Hello, world, with UIKit wrapper")
                .scaleEffect(scale)
                .onTapGesture {
                    withOptionalAnimation {
                        self.scale += 1.5
                    }
                }
                .padding()
            
            Text("Hello, reduced transparency")
                .padding()
                .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
                .foregroundColor(Color.white)
                .clipShape(Capsule())
            
        }
    }
    
    // UIKit wrapper function
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body:() throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
