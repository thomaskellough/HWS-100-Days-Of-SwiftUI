//
//  ContentView.swift
//  Milestone 4-6 Edutainment
//
//  Created by Thomas Kellough on 8/28/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var playView = false
    @State private var counts = (1, 1)
    @State private var difficulty = 0
    @State private var numberOfQuestions = 1
    @State private var questionNumber = 1
    @State private var answerChoices: [String] = []
    @State private var arithmetic = "+"
    let arithmeticOptions = ["+", "-", "x"]
    @State private var difficultyLevel = 0
    @State private var answer = 0
    @State private var animals = [
        "bear",
        "buffalo",
        "zebra",
        "whale",
        "walrus",
        "snake",
        "sloth",
        "rhino",
        "rabbit",
        "pig",
        "penguin",
        "parrot",
        "panda",
        "owl",
        "narwhal",
        "moose",
        "monkey",
        "horse",
        "hippo",
        "gorilla",
        "goat",
        "giraffe",
        "frog",
        "elephant",
        "duck",
        "dog",
        "crocodile",
        "cow",
        "chicken",
        "chick"
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.yellow, .green]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                Group {
                    if playView {
                        Play(counts: $counts, answerChoices: $answerChoices, arithmetic: $arithmetic, answer: $answer, numberOfQuestions: $numberOfQuestions, questionNumber: $questionNumber,animal: animals.randomElement() ?? "bear")
                    } else {
                        Settings(difficulty: $difficulty, numberOfQuestions: $numberOfQuestions)
                    }
                    
                }
            }
            .navigationBarTitle(playView ? "Play!" : "Settings")
            .navigationBarItems(trailing: Button(playView ? "Settings" : "Play") {
                self.playView.toggle()
                
                if self.playView {
                    self.generateQuestion()
                }
            })
        }.onAppear {
            self.generateQuestion()
        }
    }
    
    private func generateQuestion() {
        var leftNumber = 1
        var rightNumber = 1
        var operatorIndex = 0
        
        switch difficultyLevel {
        case 0:
            leftNumber = Int.random(in: 0...9)
            rightNumber = Int.random(in: 0...9)
            operatorIndex = Int.random(in: 0...1)
        case 1:
            leftNumber = Int.random(in: 0...10)
            rightNumber = Int.random(in: 0...10)
            operatorIndex = Int.random(in: 0...2)
        case 2:
            leftNumber = Int.random(in: 0...12)
            rightNumber = Int.random(in: 0...12)
            operatorIndex = Int.random(in: 0...2)
        default:
            break
        }
        
        self.counts = (leftNumber, rightNumber)
        self.arithmetic = arithmeticOptions[operatorIndex]
        self.answer = self.calculateAnswer(left: leftNumber, right: rightNumber)
        self.answerChoices = self.getAnswerChoices(left: leftNumber, right: rightNumber)
    }
    
    private func calculateAnswer(left: Int, right: Int) -> Int {
        let numOne = left
        let numTwo = right
        
        switch self.arithmetic {
        case "+":
            return numOne + numTwo
        case "-":
            return numOne - numTwo
        case "x":
            return numOne * numTwo
        default:
            fatalError("Error! Could not find arithmetic function!")
        }
    }
    
    private func getAnswerChoices(left: Int, right: Int) -> [String] {
        let answer = self.answer
        let wrongOne = left + right
        let wrongTwo = left * right
        let wrongThree = left - right
        let wrongFour = right - left
        let wrongFive = Int.random(in: 0...144)
        
        var choices = [
            String(wrongOne),
            String(wrongTwo),
            String(wrongThree),
            String(wrongFour),
            String(wrongFive)
        ]
        if let index = choices.firstIndex(of: String(answer)) {
            choices.remove(at: index)
        }
        choices = Array(Set(choices))
        choices = Array(choices.shuffled().prefix(3))
        choices.append(String(answer))
        
        return choices.shuffled()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
