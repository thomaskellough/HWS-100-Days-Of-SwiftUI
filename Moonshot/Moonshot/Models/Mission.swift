//
//  Mission.swift
//  Moonshot
//
//  Created by Thomas Kellough on 9/6/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var crewName: String {
        var crewString = ""
        for member in crew {
            crewString += ", \(member.name.capitalized)"
        }
        
        return crewString.replacingFirstOccurrence(of: ", ", with: "")
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}

