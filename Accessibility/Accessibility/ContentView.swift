//
//  ContentView.swift
//  Accessibility
//
//  Created by Thomas Kellough on 11/28/20.
//

import SwiftUI

struct ContentView: View {
    @State private var estimate = 25.0
    
    var body: some View {
        VStack {
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
