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
    @State private var counts = (0, 0)
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
                        Play(animal: animals.randomElement() ?? "bear")
                    } else {
                        Settings()
                    }
                    
                }
            }
            .navigationBarTitle(playView ? "Play!" : "Settings")
            .navigationBarItems(trailing: Button(playView ? "Settings" : "Play") {
                self.playView.toggle()
                
                if self.playView {
                    self.startGame()
                }
            })
        }.onAppear {
            self.startGame()
        }
    }
    
    func startGame() {
        self.counts = (Int.random(in: 1...12), Int.random(in: 1...12))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct Play: View {
    
    @State private var arithmetic = "+"
    @State private var answer = 0
    @State private var questionNumber = 1
    @State private var difficultyLevel = 0
    @State private var count = (1, 1)
    
//    @State private var questionCount = 5
//    @State private var numberOfQuestions = 1
    
    let arithmeticOptions = ["+", "-", "x"]
    let animal: String
    
    private func numberOfRows(total: Int) -> Int{
        switch total {
        case 0...3:
            return 1
        case 4...6:
            return 2
        case 7...9:
            return 3
        case 10...12:
            return 4
        default:
            return 0
        }
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Group {
                    VStack {
                        ForEach(0 ..< numberOfRows(total: count.0)) {row in
                            if row == (self.numberOfRows(total: self.count.0) - 1) {
                                AnimalView(animal: self.animal, animalCount: (self.count.0 % 3) == 0 ? 3 : (self.count.0 % 3))
                            } else {
                                AnimalView(animal: self.animal, animalCount: 3)
                            }
                        }
                    }
                }
                
                Text(arithmetic)
                    .font(.largeTitle)
                
                Group {
                    VStack {
                        ForEach(0 ..< numberOfRows(total: count.1)) {row in
                            if row == (self.numberOfRows(total: self.count.1) - 1) {
                                AnimalView(animal: self.animal, animalCount: (self.count.1 % 3) == 0 ? 3 : (self.count.1 % 3))
                            } else {
                                AnimalView(animal: self.animal, animalCount: 3)
                            }
                        }
                    }
                }
            }
            Spacer()
            
            HStack {
                ForEach(getAnswerChoices(), id: \.self) { answer in
                    Button(answer) {
                        self.checkAnswer(answer: answer)
                    }
                    .frame(width: 80, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .foregroundColor(.white)
                }
            }
            
            Spacer()
            
        }.onAppear {
            self.generateQuestion()
            self.arithmetic = self.arithmeticOptions.randomElement() ?? "+"
            self.calculateAnswer()
        }
    }
    
    private func calculateAnswer() {
        let numOne = self.count.0
        let numTwo = self.count.1
        
        switch self.arithmetic {
        case "+":
            self.answer = numOne + numTwo
        case "-":
            self.answer = numOne - numTwo
        case "x":
            self.answer = numOne * numTwo
        default:
            fatalError("Error! Could not find arithmetic function!")
        }
    }
    
    private func checkAnswer(answer: String) {
        if let answer = Int(answer) {
            if answer == self.answer {
                print("Great job!")
                return
            }
        }
        
        print("Ouch")
    }
    
    func generateQuestion() {
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
        
        self.count = (leftNumber, rightNumber)
        self.arithmetic = arithmeticOptions[operatorIndex]
    }
    
    private func getAnswerChoices() -> [String] {
        let answer = self.answer
        let wrongOne = count.0 + count.1
        let wrongTwo = count.0 * count.1
        let wrongThree = count.0 - count.1
        let wrongFour = count.1 - count.0
        let wrongFive = Int.random(in: 0...144)
        
        var answerChoices = [
            String(wrongOne),
            String(wrongTwo),
            String(wrongThree),
            String(wrongFour),
            String(wrongFive)
        ]
        answerChoices = Array(Set(answerChoices))
        answerChoices = Array(answerChoices.shuffled().prefix(3))
        answerChoices.append(String(answer))
        
        return answerChoices.shuffled()
    }
}

struct AnimalView: View {
    let animal: String
    var animalCount: Int
    
    var body: some View {
        HStack {
            ForEach(0 ..< animalCount) { _ in
                Image(self.animal)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct Settings: View {
    
    @State public var numberOfQuestions = 1
    @State public var difficultyLevel = 1
    let numberOfQuestionsList = [5, 10, 15, 20]
    let difficultyLevels = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        VStack {
            Section (header: Text("Difficulty level")) {
                Picker("Difficulty level", selection: $difficultyLevel) {
                    ForEach(0 ..< difficultyLevels.count) {
                        Text("\(self.difficultyLevels[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section (header: Text("How many questions per round?")){
                Picker("Number of questions", selection: $numberOfQuestions) {
                    ForEach(0 ..< numberOfQuestionsList.count) {
                        Text("\(self.numberOfQuestionsList[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
        Spacer()
            
        }
        .foregroundColor(.white)
    }
}
