//
//  Roll+CoreDataProperties.swift
//  Milestone 16-18 DiceRoller
//
//  Created by Thomas Kellough on 12/16/20.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var rolls: Data?
    @NSManaged public var total: Int16

}

extension Roll : Identifiable {

}
