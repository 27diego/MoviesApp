//
//  PersonCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/15/21.
//
//

import Foundation
import CoreData

@objc(PersonCD)
public class PersonCD: NSManagedObject, Codable {
    enum PersonCodingKeys: String, CodingKey {
        case identifier="id", name, profilePath, popularity
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("failed to provide context")
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: PersonCodingKeys.self)
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.name = try container.decode(String.self, forKey: .name)
        self.profilePath = try container.decode(String.self, forKey: .profilePath)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PersonCodingKeys.self)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(name, forKey: .name)
        try container.encode(profilePath, forKey: .profilePath)
        try container.encode(popularity, forKey: .popularity)
    }
    
}

extension PersonCD {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonCD> {
        return NSFetchRequest<PersonCD>(entityName: "PersonCD")
    }
    
    @NSManaged public var identifier: Int
    @NSManaged public var name: String
    @NSManaged public var profilePath: String?
    @NSManaged public var popularity: Double
    @NSManaged public var lastUpdated: String?
    
}

extension PersonCD : Identifiable {
    
}
