//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Thomas Kellough on 7/7/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnwser = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var animationAmount = 0.0
    @State private var fadeAmount = 1.0
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnwser])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .fixedSize(horizontal: true, vertical: true)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagView(country: self.countries[number])
                    }
                    .opacity(number == self.correctAnwser ? 1.0 : self.fadeAmount)
                    .rotation3DEffect(.degrees(number == self.correctAnwser ? self.animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                }
                
                Text("Current Score: \(score)")
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 1))
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        
        withAnimation(.easeInOut) {
            self.fadeAmount = 0.25
        }
        
        if number == correctAnwser {
            scoreTitle = "Correct"
            score += 1
            
            withAnimation(.easeInOut) {
                self.animationAmount += 360
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                self.fadeAmount = 0.0
            }
        }
        
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnwser = Int.random(in: 0...2)
        
        fadeAmount = 1.0
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    let country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .accessibility(label: Text(self.labels[self.country] ?? "Unknown flag"))
    }
}
