//
//  ContentView.swift
//  Flashzilla
//
//  Created by Thomas Kellough on 12/13/20.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.example, count: 10)
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) {index in
                        CardView(card: self.cards[index]) {
                            withAnimation {
                                self.removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                    }
                }
            }
        }
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
