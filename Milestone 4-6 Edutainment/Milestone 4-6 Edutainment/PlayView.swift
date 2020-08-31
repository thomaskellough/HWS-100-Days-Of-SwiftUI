//
//  PlayView.swift
//  Milestone 4-6 Edutainment
//
//  Created by Thomas Kellough on 8/31/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import SwiftUI

struct Play: View {
    @Binding
    var counts: (Int, Int)
    
    @Binding
    var answerChoices: [String]
    
    @Binding
    var arithmetic: String
    
    @Binding
    var answer: Int
    
    @Binding
    var numberOfQuestions: Int
    
    @Binding
    var questionNumber: Int

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
                        ForEach(0 ..< numberOfRows(total: counts.0)) {row in
                            if row == (self.numberOfRows(total: self.counts.0) - 1) {
                                AnimalView(animal: self.animal, animalCount: (self.counts.0 % 3) == 0 ? 3 : (self.counts.0 % 3))
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
                        ForEach(0 ..< numberOfRows(total: counts.1)) {row in
                            if row == (self.numberOfRows(total: self.counts.1) - 1) {
                                AnimalView(animal: self.animal, animalCount: (self.counts.1 % 3) == 0 ? 3 : (self.counts.1 % 3))
                            } else {
                                AnimalView(animal: self.animal, animalCount: 3)
                            }
                        }
                    }
                }
            }
            Spacer()
            
            HStack {
                ForEach(answerChoices, id: \.self) { answer in
                    Button(answer) {
                        self.checkAnswer(answer, answer: self.answer)
                    }
                    .frame(width: 80, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .foregroundColor(.white)
                }
            }
            
            Spacer()
            
        }
    }
    
    private func checkAnswer(_ answerButton: String, answer: Int) {
        if let answerText = Int(answerButton) {
            if answerText == self.answer {
                endGame()
                print("Success!")
                return
            }
        }

        print("Ouch")
    }
    
    private func endGame() {
        if questionNumber == numberOfQuestions {
            questionNumber = 1
            
            restartGame()
        }
    }
    
    private func restartGame() {
        print("Game restarted")
    }
}

