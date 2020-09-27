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
                ForEach(activities.activities.indices, id: \.self) { index in
                    NavigationLink(destination: ActivityDetailView(activities: self.activities, index: index)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(activities.activities[index].name)
                                    .font(.title)
                                    .foregroundColor(.blue)
                                Spacer()
                                Text("\(activities.activities[index].count)")
                                    .font(.title)
                                    .foregroundColor(.green)
                            }
                            Text(activities.activities[index].description)
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .onDelete(perform: delete)
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
    
    func delete(at offsets: IndexSet) {
        activities.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
