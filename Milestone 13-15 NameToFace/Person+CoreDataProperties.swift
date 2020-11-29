//
//  Person+CoreDataProperties.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//
//

import Foundation
import CoreData
import SwiftUI


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageUrl: UUID?
    
    public var unwrappedName: String {
        name?.capitalized ?? "Unknown"
    }
    
    public var image: Image? {
        if let uuid = imageUrl {
            let path = FileManager().documentDirectory.appendingPathComponent(uuid.uuidString)
            do {
                let data = try Data(contentsOf: path)
                if let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                 
                    return image
                }
            } catch let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        return nil
    }

}

extension Person : Identifiable {

}
