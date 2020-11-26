//
//  CDFriend+CoreDataProperties.swift
//  Milestone 10-12 Friendface
//
//  Created by Thomas Kellough on 11/26/20.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friends: String?
    
    // MARK: Unwrapped propeties
    public var unwrappedName: String {
        name ?? "Unknown Name"
    }
    public var unwrappedAge: Int {
        Int(age)
    }
    public var unwrappedCompany: String {
        company ?? "Unknown company"
    }
    public var unwrappedEmail: String {
        email ?? "Unnown email"
    }
    public var unwrappedAddress: String {
        address ?? "Unknown address"
    }
    public var cityAndState: String {
        guard let address = address else { return "Unknown address" }
        let components = address.split(separator: ",")
        return "\(components[1].trimmingCharacters(in: .whitespacesAndNewlines)), \(components[2])"
    }
    public var unwrappedAbout: String {
        about ?? "Unknown about info"
    }
    public var friendArray: [String] {
        friends?.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) } ?? []
    }
    public var numberOfFriends: Int {
        friendArray.count
    
    }

}

extension CDFriend : Identifiable {

}
