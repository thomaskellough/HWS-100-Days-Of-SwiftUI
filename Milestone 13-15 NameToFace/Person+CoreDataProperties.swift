//
//  Person+CoreDataProperties.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageUrl: UUID?
    
    public var unwrappedName: String {
        name?.capitalized ?? "Unknown"
    }

}

extension Person : Identifiable {

}
