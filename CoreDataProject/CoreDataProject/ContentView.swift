//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Thomas Kellough on 11/21/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button("Save") {
            // Save only if there are changes!
            if self.moc.hasChanges {
                try? self.moc.save()
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
