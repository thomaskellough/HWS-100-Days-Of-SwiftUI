//
//  ContentView.swift
//  Milestone 7-9 HabitTracker
//
//  Created by Thomas Kellough on 9/20/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false;
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities) { activity in
                    VStack {
                        HStack {
                            Text(activity.name)
                            Spacer()
                            Text("\(activity.count)")
                        }
                        Text(activity.description)
                    }
                }
            }
            .navigationTitle("My Activities")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.showingAddActivity.toggle()
                    }) {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showingAddActivity, content: {
                        AddActivityView(activities: self.activities)
                    })
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
