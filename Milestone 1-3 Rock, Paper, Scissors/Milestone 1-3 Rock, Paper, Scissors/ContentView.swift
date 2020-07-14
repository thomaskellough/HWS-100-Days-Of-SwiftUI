//
//  ContentView.swift
//  Milestone 1-3 Rock, Paper, Scissors
//
//  Created by Thomas Kellough on 7/12/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let opponent = ["rock", "paper", "scissors"]
    
    @State private var score = 0
    @State private var shouldWin = Bool.random()
    @State private var randomElement = Int.random(in: 0...3)
    @State private var opponentPlay = "rock"
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 30) {
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.title)
                    Text(shouldWin ? "Win" : "Lose")
                        .foregroundColor(shouldWin ? .green : .red)
                        .font(.largeTitle)
                    Image(opponentPlay)
                    Spacer()
                    HStack (spacing: 30){
                        ForEach(0 ..< 3) { number in
                            Button(action: {
                                self.play(choice: self.opponent[number])
                            }) {
                                Image(self.opponent[number])
                                    .renderingMode(.original)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    
    func setUpGame() {
        shouldPlayerWin()
        randomElement = Int.random(in: 0...2)
        opponentPlay = opponent[randomElement]
    }
    
    func shouldPlayerWin() {
        shouldWin = Bool.random()
    }
    
    func play(choice: String) {
        guard choice != opponentPlay else {
            setUpGame()
            return
        }
        
        let point = shouldWin ? 1 : -1
        
        switch (choice, opponentPlay) {
        case ("paper", "rock"):
            score += point
        case ("scissors", "paper"):
            score += point
        case ("rock", "scissors"):
            score += point
        default:
            score -= point
        }
        
        setUpGame()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
