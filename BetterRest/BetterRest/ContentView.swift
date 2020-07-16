//
//  ContentView.swift
//  BetterRest
//
//  Created by Thomas Kellough on 7/13/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var bedTime = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Your ideal bedtime is...")) {
                    Text(bedTime)
                        .font(.largeTitle)
                }
                
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: [.hourAndMinute])
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(onIncrement: {
                        self.sleepAmount += 0.25
                        if self.sleepAmount > 12 {
                            self.sleepAmount = 12
                        }
                        self.calculateBedtime()
                    }, onDecrement: {
                        self.sleepAmount -= 0.25
                        if self.sleepAmount < 4 {
                            self.sleepAmount = 4
                        }
                        self.calculateBedtime()
                    }) {
                        Text("\(sleepAmount, specifier: "%g") hours of sleep")
                    }
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Stepper(onIncrement: {
                        self.coffeeAmount += 1
                        if self.coffeeAmount > 10 {
                            self.coffeeAmount = 10
                        }
                        self.calculateBedtime()
                    }, onDecrement: {
                        self.coffeeAmount -= 1
                        if self.coffeeAmount < 0 {
                            self.coffeeAmount = 0
                        }
                        self.calculateBedtime()
                    }) {
                        if self.coffeeAmount == 1 {
                            Text("\(coffeeAmount) cup of coffee")
                        } else {
                            Text("\(coffeeAmount) cups of coffee")
                        }
                    }
                }
                
                
            }
            .navigationBarTitle("Better Rest")
        }
        .onAppear(perform: self.calculateBedtime)
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() {
        let model = BetterRest()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            bedTime = formatter.string(from: sleepTime)
            
        } catch {
            bedTime = "Sorry, there was a problem calculating the prediction"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
