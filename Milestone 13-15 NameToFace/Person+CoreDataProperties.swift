//
//  Person+CoreDataProperties.swift
//  Milestone 13-15 NameToFace
//
//  Created by Thomas Kellough on 11/28/20.
//
//

import CoreData
import Foundation
import MapKit
import SwiftUI

extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var imageUrl: UUID?
    @NSManaged public var name: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

    public var unwrappedName: String {
        name?.capitalized ?? "Unknown"
    }
    
    public var location: CLLocationCoordinate2D? {
        if let lat = Double(latitude ?? "") {
            if let lon = Double(longitude ?? "") {
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                return coordinate
            }
        }
        
        return nil
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
