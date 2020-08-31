//
//  SettingsView.swift
//  Milestone 4-6 Edutainment
//
//  Created by Thomas Kellough on 8/31/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import SwiftUI

struct Settings: View {
    @Binding
    var difficulty: Int
    @Binding
    var numberOfQuestions: Int
    
    let numberOfQuestionsList = [5, 10, 15, 20]
    let difficultyLevels = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        VStack {
            Section (header: Text("Difficulty level")) {
                Picker("Difficulty level", selection: $difficulty) {
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
