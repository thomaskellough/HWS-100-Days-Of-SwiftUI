//
//  BookworkApp.swift
//  Bookwork
//
//  Created by Thomas Kellough on 10/18/20.
//

import SwiftUI

@main
struct BookworkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
