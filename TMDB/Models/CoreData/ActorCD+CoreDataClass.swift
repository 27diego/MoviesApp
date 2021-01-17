//
//  ActorCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/14/21.
//
//

import Foundation
import CoreData

@objc(ActorCD)
public class ActorCD: NSManagedObject, Codable {
    enum ActorCodingKeys: String, CodingKey {
        case character, identifier="id", name, order, popularity, profilePath, lastUpdated, movies
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Failed to provide correct context in decoder")
        }
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: ActorCodingKeys.self)
        self.character = try container.decode(String.self, forKey: .character)
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.name = try container.decode(String.self, forKey: .name)
        self.order = try container.decode(Int.self, forKey: .order)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.profilePath = try container.decode(String.self, forKey: .profilePath)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ActorCodingKeys.self)
        try container.encode(character, forKey: .character)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(name, forKey: .name)
        try container.encode(order, forKey: .order)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(profilePath, forKey: .profilePath)
    }

}

extension ActorCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActorCD> {
        return NSFetchRequest<ActorCD>(entityName: "ActorCD")
    }

    @NSManaged public var character: String?
    @NSManaged public var identifier: Int
    @NSManaged public var name: String
    @NSManaged public var order: Int
    @NSManaged public var popularity: Double
    @NSManaged public var profilePath: String?
    @NSManaged public var lastUpdated: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension ActorCD {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieDescriptionCD)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieDescriptionCD)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension ActorCD : Identifiable {

}

extension ActorCD: PersonCDProtocol {
    
}

extension ActorCD {
    static func findOrInsert(id: Int, context: NSManagedObjectContext) -> ActorCD {
        let request = NSFetchRequest<ActorCD>(entityName: "ActorCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ActorCD.identifier), id as NSNumber)
        let results = try? context.fetch(request)
        if let first = results?.first {
            return first
        }
        
        let actor = ActorCD(context: context)
        actor.identifier = id
        
        return actor
    }
}
