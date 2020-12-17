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
    @NSManaged public var date: Date?
    
    public var rollsArrayString: String {
        let array = try! JSONDecoder().decode([String].self, from: rolls!)
        let numbersOnlyArray = array.map { $0.split(separator: "_")[1] }
        return numbersOnlyArray.joined(separator: ", ")
    }

}

extension Roll : Identifiable {

}
