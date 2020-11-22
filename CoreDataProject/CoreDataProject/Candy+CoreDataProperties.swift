//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Thomas Kellough on 11/21/20.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
    
    public var wrappedOrigin: String {
        origin?.fullName ?? "Unknown Origin"
    }

}

extension Candy : Identifiable {

}
