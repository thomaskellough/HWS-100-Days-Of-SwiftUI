//
//  PracticeContentView.swift
//  BetterRest
//
//  Created by Thomas Kellough on 7/13/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import SwiftUI

struct PracticeContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()
    let now = Date()
    let tomorrow = Date().addingTimeInterval(86400)
    
    var body: some View {
        
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                // %.2g removes trailing insignificant 0's
                Text("\(sleepAmount, specifier: "%.2g") hours")
            }
            Form {
                DatePicker("Please select a date", selection: $wakeUp, displayedComponents: .date)
                DatePicker("Please select a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            }
            // This still allows for voice over, but hides the label
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()
            
//            DatePicker("Please enter date", selection: $wakeUp, in: Date()...tomorrow)
//            DatePicker("Please enter date", selection: $wakeUp, in: Date()...)
            Button(action: {
                self.print8am()
            }) {
                Text("Print 8am")
            }
        }
        
    }
    
    func print8am() {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date()
        print(date)
    }
    
    func date() {
        let someDate = Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: someDate)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: someDate)
    }
}

struct PracticeContentView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeContentView()
    }
}
