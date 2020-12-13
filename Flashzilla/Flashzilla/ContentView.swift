//
//  ContentView.swift
//  Flashzilla
//
//  Created by Thomas Kellough on 12/13/20.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {

    var body: some View {
        Text("Hello, world")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("Moving to the background")
            }
        
        Text("Hello, screenshot")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                print("User took a screenshot")
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
