//
//  Prospects.swift
//  HotProspects
//
//  Created by Thomas Kellough on 12/12/20.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
}
