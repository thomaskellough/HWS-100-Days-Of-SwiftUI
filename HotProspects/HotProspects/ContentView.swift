//
//  ContentView.swift
//  HotProspects
//
//  Created by Thomas Kellough on 11/29/20.
//

import UserNotifications
import SamplePackage
import SwiftUI

struct ContentView: View {
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        VStack {
            Text(results)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
