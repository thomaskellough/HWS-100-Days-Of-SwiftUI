//
//  Friend.swift
//  Milestone 10-12 Friendface
//
//  Created by Thomas Kellough on 11/22/20.
//

import Foundation

// MARK: - FriendElement
struct Friend: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Connection]
    var friendList: String {
        return friends.map { $0.name }.joined(separator: ", ")
    }
    
    var cityAndState: String {
        let addressParts = address.split(separator: ",")
        let city = addressParts[1].trimmingCharacters(in: .whitespacesAndNewlines)
        let state = addressParts[2]
        return "\(city), \(state)"
    }
}

struct Connection: Codable {
    var id: UUID
    var name: String
}

//// MARK: - FriendClass
//struct FriendClass: Codable {
//    let id, name: String
//}

