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
    @State private var enabled = false
    
    @State private var dragAmount = CGSize.zero
    
    let letters = Array("Hello SwiftUI")
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? Color.blue : Color.red)
                        .offset(self.dragAmount)
                        .animation(Animation.default.delay(Double(num) / 20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                }
            )
            
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded {  _ in
                            withAnimation(.spring()) {
                                self.dragAmount = .zero
                            }
                        }
                )
                .animation(.spring())
            
            
            
            
//            Button("Flip Y") {
//                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                    self.animationAmount += 360
//                }
//            }
//            .styleButton(color: Color.red)
//            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
//            .padding()
//
//            Button("Flip X") {
//                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                    self.animationAmount += 360
//                }
//            }
//            .styleButton(color: Color.blue)
//            .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0, z: 0))
//            .padding()
//
//            Button("Flip Z") {
//                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                    self.animationAmount += 360
//                }
//            }
//            .styleButton(color: Color.green)
//            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 1))
//            .padding()
//
//            Button("Color Change") {
//                self.enabled.toggle()
//            }
//            .frame(width: 200, height: 200)
//            .styleButtonStack(color: enabled ? Color.yellow : Color.purple)
//            .animation(.default)
//            .foregroundColor(.black)
//            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//            .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Custom View Modifier for Explicit Animations
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

// CustomView Modifer for Animation Stack
struct ButtonStyleStack: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(50)
            .background(color)
            .foregroundColor(.white)
    }
}

extension View {
    func styleButtonStack(color: Color) -> some View {
        self.modifier(ButtonStyleStack(color: color))
    }
}
