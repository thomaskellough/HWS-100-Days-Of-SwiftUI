//
//  SettingsView.swift
//  Milestone 16-18 DiceRoller
//
//  Created by Thomas Kellough on 12/16/20.
//

import SwiftUI

struct SettingsView: View {
    @State private var numberOfDice = 2
    @State private var chosenType = "d6"
    @State private var stepperValue = UserDefaults.standard.integer(forKey: "numberOfDice")
    let typeOfDice = ["d4", "d6", "d8", "d10", "d12", "d20", "d100"]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Stepper(onIncrement: {
                        if stepperValue < 7 {
                            self.stepperValue += 2
                            self.save()
                        }
                    }, onDecrement: {
                        if stepperValue > 2 {
                            self.stepperValue -= 2
                            self.save()
                        }
                    }) {
                        Text("Number of dice: \(self.stepperValue)")
                    }
                    
                    // Have no dice images for this right now
//                    Picker("Type of dice", selection: $chosenType) {
//                        ForEach(typeOfDice, id: \.self) {
//                            Text($0)
//                        }
//                    }
                }
            }
            .navigationBarTitle("Settings")
            .onDisappear(perform: save)
        }
    }
    
    func save() {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(stepperValue, forKey: "numberOfDice")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
