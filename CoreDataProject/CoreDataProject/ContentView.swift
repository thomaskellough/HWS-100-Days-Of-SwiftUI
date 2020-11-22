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
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    @State private var filterValue = "Switzerland"
    @State private var sortDescriptors: [NSSortDescriptor] = [
        NSSortDescriptor(keyPath: \Candy.name, ascending: true)
    ]
    @State private var predicate: String = ">"
    
    var body: some View {
        VStack {
            
            FilteredList(predicate: predicate, filterKey: "name", filterValue: filterValue, sortDescriptors: sortDescriptors) { (candy: Candy) in
                Text(candy.wrappedName)
//                ForEach(country.candyArray, id: \.self) { candy in
//                    Text(candy.wrappedName)
//                }
            }
            
            List {
                ForEach(countries, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Filter Twix/Toblerone") {
                self.predicate = ">"
                self.filterValue = "S"
            }
            
            Button("Filter All") {
                self.predicate = ">"
                self.filterValue = "A"
            }
            
            Button("Begins with M") {
                self.predicate = "BEGINSWITH"
                self.filterValue = "M"
            }
            
            Button("Ends with T") {
                self.predicate = "ENDSWITH[c]"
                self.filterValue = "T"
            }
            
            Button("Sort A-Z") {
                self.sortDescriptors = [
                    NSSortDescriptor(keyPath: \Candy.name, ascending: true)
                ]
            }
            
            Button("Sort Z-A") {
                self.sortDescriptors = [
                    NSSortDescriptor(keyPath: \Candy.name, ascending: false)
                ]
            }
            
            Button("Add") {
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: self.moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: self.moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                if moc.hasChanges {
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
