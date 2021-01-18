//
//  CrewMemberCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/14/21.
//
//

import Foundation
import CoreData

@objc(CrewMemberCD)
public class CrewMemberCD: NSManagedObject {

}


extension CrewMemberCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrewMemberCD> {
        return NSFetchRequest<CrewMemberCD>(entityName: "CrewMemberCD")
    }

    @NSManaged public var department: String?
    @NSManaged public var identifier: Int
    @NSManaged public var job: String?
    @NSManaged public var name: String
    @NSManaged public var profilePath: String?
    @NSManaged public var lastUpdated: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension CrewMemberCD {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieDescriptionCD)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieDescriptionCD)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension CrewMemberCD : Identifiable {

}

extension CrewMemberCD: PersonCDProtocol {
    
}

extension CrewMemberCD {
    static func getCrewMember(by id: Int) -> NSFetchRequest<CrewMemberCD>{
        let request = NSFetchRequest<CrewMemberCD>(entityName: "CrewMemberCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(CrewMemberCD.identifier), id as NSNumber)
        request.sortDescriptors = []
        return request
    }
    
    static func fetchCrewMembers(movie id: Int) -> NSFetchRequest<CrewMemberCD> {
        let request = NSFetchRequest<CrewMemberCD>(entityName: "CrewMemberCD")
        request.predicate = NSPredicate(format: "ANY movies.identifier == %@", id as NSNumber)
        request.sortDescriptors = []
        request.fetchLimit = 10
        return request
    }
}

extension CrewMemberCD {
    static func findOrInsert(by id: Int, context: NSManagedObjectContext) -> CrewMemberCD {
        let request = NSFetchRequest<CrewMemberCD>(entityName: "CrewMemberCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(ActorCD.identifier), id as NSNumber)
        let results = try? context.fetch(request)
        if let first = results?.first {
            return first
        }
        
        let actor = CrewMemberCD(context: context)
        actor.identifier = id
        
        return actor
    }
}
