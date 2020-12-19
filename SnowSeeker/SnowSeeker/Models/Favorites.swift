//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Thomas Kellough on 12/18/20.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        if let savedArray = UserDefaults.standard.value(forKey: saveKey) as? [String] {
            self.resorts = Set(savedArray)
        } else {
            self.resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        let saveArray = Array(self.resorts)
        UserDefaults.standard.setValue(saveArray, forKey: saveKey)
    }
}
