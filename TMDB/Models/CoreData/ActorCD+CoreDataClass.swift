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
public class ActorCD: NSManagedObject {

}

extension ActorCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActorCD> {
        return NSFetchRequest<ActorCD>(entityName: "ActorCD")
    }

    @NSManaged public var character: String?
    @NSManaged public var identifier: Int32
    @NSManaged public var name: String?
    @NSManaged public var order: Int32
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
