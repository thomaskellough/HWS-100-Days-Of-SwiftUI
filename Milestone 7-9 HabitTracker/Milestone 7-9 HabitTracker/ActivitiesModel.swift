//
//  ActivitiesModel.swift
//  Milestone 7-9 HabitTracker
//
//  Created by Thomas Kellough on 9/21/20.
//

import Foundation

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.setValue(encoded, forKey: "activities")
            }
        }
    }
    
    init() {
        if let activities = UserDefaults.standard.data(forKey: "activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activities) {
                self.activities = decoded
                return
            }
        }
        
        self.activities = []
    }
}

struct Activity: Codable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int
}
