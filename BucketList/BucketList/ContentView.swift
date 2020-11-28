//
//  ContentView.swift
//  BucketList
//
//  Created by Thomas Kellough on 11/27/20.
//

import SwiftUI

struct ContentView: View {
    
    let users = [
        User(firstName: "Harry", lastName: "Potter"),
        User(firstName: "Hermione", lastName: "Granger"),
        User(firstName: "Ronalds", lastName: "Weasley")
    ].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
