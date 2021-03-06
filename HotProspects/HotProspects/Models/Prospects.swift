//
//  Prospects.swift
//  HotProspects
//
//  Created by Thomas Kellough on 12/12/20.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    let id = UUID()
    var date = Date()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.emailAddress == rhs.emailAddress
    }
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "ProspectsSavedData"
    
    init() {
        let url = FileManager().documentDirectory.appendingPathComponent(Self.saveKey)
        do {
            let data = try Data(contentsOf: url)
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            } else {
                assertionFailure("Failed to decode data")
            }
        } catch let error {
            print("Error reading data: \(error.localizedDescription)")
        }

        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            if let str = String(data: encoded, encoding: .utf8) {
                let url = FileManager().documentDirectory.appendingPathComponent(Self.saveKey)
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                } catch let error {
                    print("Error writing data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func sortProspects(_ sort: String) {
        objectWillChange.send()
        switch sort {
        case "name":
            self.people.sort()
        case "date":
            self.people = self.people.sorted { $0.date < $1.date }
        default:
            break
        }
    }
}
