//
//  ContentView.swift
//  BucketList
//
//  Created by Thomas Kellough on 11/27/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = FileManager().documentDirectory.appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
