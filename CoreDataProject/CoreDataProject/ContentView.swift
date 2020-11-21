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
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                if self.moc.hasChanges {
                    try? self.moc.save()
                }
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
