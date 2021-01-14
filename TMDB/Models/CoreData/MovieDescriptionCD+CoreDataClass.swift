//
//  MovieDescriptionCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/14/21.
//
//

import Foundation
import CoreData

@objc(MovieDescriptionCD)
public class MovieDescriptionCD: NSManagedObject {

}


extension MovieDescriptionCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDescriptionCD> {
        return NSFetchRequest<MovieDescriptionCD>(entityName: "MovieDescriptionCD")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var runtime: Int64
    @NSManaged public var title: String?
    @NSManaged public var lastUpdated: String?
    @NSManaged public var actors: NSSet?
    @NSManaged public var crewMembers: NSSet?
    @NSManaged public var movie: MovieCD?

}

// MARK: Generated accessors for actors
extension MovieDescriptionCD {

    @objc(addActorsObject:)
    @NSManaged public func addToActors(_ value: ActorCD)

    @objc(removeActorsObject:)
    @NSManaged public func removeFromActors(_ value: ActorCD)

    @objc(addActors:)
    @NSManaged public func addToActors(_ values: NSSet)

    @objc(removeActors:)
    @NSManaged public func removeFromActors(_ values: NSSet)

}

// MARK: Generated accessors for crewMembers
extension MovieDescriptionCD {

    @objc(addCrewMembersObject:)
    @NSManaged public func addToCrewMembers(_ value: CrewMemberCD)

    @objc(removeCrewMembersObject:)
    @NSManaged public func removeFromCrewMembers(_ value: CrewMemberCD)

    @objc(addCrewMembers:)
    @NSManaged public func addToCrewMembers(_ values: NSSet)

    @objc(removeCrewMembers:)
    @NSManaged public func removeFromCrewMembers(_ values: NSSet)

}

extension MovieDescriptionCD : Identifiable {

}
