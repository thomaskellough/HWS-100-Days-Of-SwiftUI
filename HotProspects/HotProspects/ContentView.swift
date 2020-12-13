//
//  ContentView.swift
//  HotProspects
//
//  Created by Thomas Kellough on 11/29/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "Tab 1 View"

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    self.selectedTab = "Tab 2 View"
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("Tab One")
                }
                .tag("Tab 1 View")
            Text("Tab 2")
                .onTapGesture {
                    self.selectedTab = "Tab 1 View"
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Tab Two")
                }
                .tag("Tab 2 View")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

