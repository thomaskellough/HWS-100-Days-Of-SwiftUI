//
//  ContentView.swift
//  Accessibility
//
//  Created by Thomas Kellough on 11/28/20.
//

import SwiftUI

struct ContentView: View {
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
        VStack {
            Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
                .accessibility(value: Text("\(rating) out of 5"))
            Slider(value: $estimate, in: 0...50)
                .padding()
                .accessibility(value: Text("\(Int(estimate))"))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
