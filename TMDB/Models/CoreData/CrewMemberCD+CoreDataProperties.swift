//
//  CrewMemberCD+CoreDataProperties.swift
//  TMDB
//
//  Created by Developer on 1/12/21.
//
//

import Foundation
import CoreData


extension CrewMemberCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrewMemberCD> {
        return NSFetchRequest<CrewMemberCD>(entityName: "CrewMemberCD")
    }

    @NSManaged public var department: String?
    @NSManaged public var id: Int32
    @NSManaged public var job: String?
    @NSManaged public var name: String?
    @NSManaged public var profilePath: String?
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
