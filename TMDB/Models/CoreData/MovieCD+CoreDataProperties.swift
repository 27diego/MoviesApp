//
//  MovieCD+CoreDataProperties.swift
//  TMDB
//
//  Created by Developer on 1/7/21.
//
//

import Foundation
import CoreData


extension MovieCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCD> {
        return NSFetchRequest<MovieCD>(entityName: "MovieCD")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int32
    @NSManaged public var overview: String
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String
    @NSManaged public var actors: NSSet?
    @NSManaged public var crewMembers: NSSet?

}

// MARK: Generated accessors for actors
extension MovieCD {

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
extension MovieCD {

    @objc(addCrewMembersObject:)
    @NSManaged public func addToCrewMembers(_ value: CrewMemberCD)

    @objc(removeCrewMembersObject:)
    @NSManaged public func removeFromCrewMembers(_ value: CrewMemberCD)

    @objc(addCrewMembers:)
    @NSManaged public func addToCrewMembers(_ values: NSSet)

    @objc(removeCrewMembers:)
    @NSManaged public func removeFromCrewMembers(_ values: NSSet)

}

extension MovieCD : Identifiable {

}
