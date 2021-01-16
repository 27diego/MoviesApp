//
//  MovieDescriptionCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/15/21.
//
//

import Foundation
import CoreData

@objc(MovieDescriptionCD)
public class MovieDescriptionCD: NSManagedObject, Codable {
    enum MovieDescriptionCodingKeys: String, CodingKey {
        case backdropPath, identifier="id", overview, popularity, posterPath, releaseDate, runtime, title
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Did not provide correct context")
        }
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: MovieDescriptionCodingKeys.self)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.runtime = try container.decode(Int.self, forKey: .runtime)
        self.title = try container.decode(String.self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MovieDescriptionCodingKeys.self)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(identifier, forKey: .identifier)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(runtime, forKey: .runtime)
        try container.encode(title, forKey: .title)
    }
    
}
extension MovieDescriptionCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieDescriptionCD> {
        return NSFetchRequest<MovieDescriptionCD>(entityName: "MovieDescriptionCD")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var identifier: Int
    @NSManaged public var lastUpdated: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var runtime: Int
    @NSManaged public var title: String?
    @NSManaged public var actors: NSSet?
    @NSManaged public var crewMembers: NSSet?
    @NSManaged public var movie: MovieCD?
    @NSManaged public var movieLinks: NSSet?
    @NSManaged public var genres: NSSet?

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

// MARK: Generated accessors for movieLinks
extension MovieDescriptionCD {

    @objc(addMovieLinksObject:)
    @NSManaged public func addToMovieLinks(_ value: MovieVideosCD)

    @objc(removeMovieLinksObject:)
    @NSManaged public func removeFromMovieLinks(_ value: MovieVideosCD)

    @objc(addMovieLinks:)
    @NSManaged public func addToMovieLinks(_ values: NSSet)

    @objc(removeMovieLinks:)
    @NSManaged public func removeFromMovieLinks(_ values: NSSet)

}

// MARK: Generated accessors for genres
extension MovieDescriptionCD {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenresCD)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenresCD)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

extension MovieDescriptionCD : Identifiable {

}
