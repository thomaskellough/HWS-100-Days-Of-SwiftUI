//
//  ActivitiesModel.swift
//  Milestone 7-9 HabitTracker
//
//  Created by Thomas Kellough on 9/21/20.
//

import Foundation

class Activities: ObservableObject {
    @Published var activities = [Activity]()
}

struct Activity: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let count: Int
}
