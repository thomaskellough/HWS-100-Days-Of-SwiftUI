//
//  ActivityDetailView.swift
//  Milestone 7-9 HabitTracker
//
//  Created by Thomas Kellough on 9/26/20.
//

import SwiftUI

struct ActivityDetailView: View {
    
    @ObservedObject var activities: Activities
    @State public var index: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Text(activities.activities[index].name)
                    .font(.title)
                Text(activities.activities[index].description)
                    .font(.title2)
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        incrementCount()
                    }, label: {
                        Text("+")
                            .modifier(ButtonViewModifer(color: .green))
                    })
                    Spacer()
                    Text("\(activities.activities[index].count)")
                        .font(.largeTitle)
                    Spacer()
                    Button(action: {
                        decrementCount()
                    }, label: {
                        Text("-")
                            .modifier(ButtonViewModifer(color: .red))
                    })
                    Spacer()
                }
                Spacer()
            }
        }
    }
    
    func incrementCount() {
        activities.activities[index].count += 1
    }
    
    func decrementCount() {
        activities.activities[index].count -= 1
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(), index: 0)
    }
}
