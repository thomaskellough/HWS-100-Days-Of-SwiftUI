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
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped")
                }
                .contentShape(Circle())
            
            Circle()
                .fill(Color.red)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Cirlce tapped")
                }
            
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("Vstack tapped")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
