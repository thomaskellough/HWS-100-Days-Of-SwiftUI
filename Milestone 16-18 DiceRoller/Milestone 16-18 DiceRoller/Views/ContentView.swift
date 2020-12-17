//
//  ContentView.swift
//  Milestone 16-18 DiceRoller
//
//  Created by Thomas Kellough on 12/16/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            RollView()
                .tabItem {
                    Image(systemName: "crown")
                    Text("Roll")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                    Text("History")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
