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
        VStack(spacing: 10) {
            Text("Challenge 1")
                .challenge1()
            CapsuleText(text: "First")
                .foregroundColor(Color.yellow)
            CapsuleText(text: "Second")
                .foregroundColor(Color.pink)
            Text("Hello, Title")
                .modifier(Title())
            Text("Hello, Subtitle")
                .subtitleStyle()
            Text("Watermarked!")
                .frame(width: 300, height: 200)
                .background(Color.yellow)
                .watermarked(with: "Hacking With Swift")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Custom View
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

// Custom View Modifier
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.white)
            .padding()
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(Color.white)
            .padding()
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// It can be a better idea to create an extension on View to make modifiers easier to use
extension View {
    func subtitleStyle() -> some View {
        self.modifier(Subtitle())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

// Challenge 1
struct Challenge1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func challenge1() -> some View {
        self.modifier(Challenge1())
    }
}
