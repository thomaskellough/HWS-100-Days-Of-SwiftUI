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
    
    var body: some View {
        VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                // %.2g removes trailing insignificant 0's
                Text("\(sleepAmount, specifier: "%.2g") hours")
            }
        }
    }
}

struct PracticeContentView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeContentView()
    }
}
