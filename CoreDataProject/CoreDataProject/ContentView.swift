//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Thomas Kellough on 11/21/20.
//

import CoreData
import SwiftUI

/*
Predicate examples
 
 "universe == %@", "Star Wars"
 "name < %@", "F"
 "universe in %@", ["Aliens", "Firefly", "Star Trek"]
 "name BEGINSWITH %@", "E"  ---- this is case-sensitive
 "name BEINGSWITH[c] %@", "e" ---- this is case-insensitive
 "NOT name BEINGSWITH[c] %@", "e"
 
 */

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"

    var body: some View {
        VStack {
            // list of matching singers
            
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                if moc.hasChanges {
                    try? self.moc.save()
                }
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Student: Hashable {
    let name: String
}
