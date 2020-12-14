//
//  ContentView.swift
//  Flashzilla
//
//  Created by Thomas Kellough on 12/13/20.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    // Get screen height to adjust card size for all devices
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    let card: Card

    @State private var isShowingAnswer = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: self.width * 0.75, height: height * 0.75)
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(card: Card.example)
        }
    }
}
