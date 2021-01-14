//
//  MovieCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/14/21.
//
//

import Foundation
import CoreData




@objc(MovieCD)
public class MovieCD: NSManagedObject, Codable {
    enum MovieCodingKeys: CodingKey {
        case backdropPath, id, overview, popularity, posterPath, releaseDate, title, lastUpdated, category, movieDescription
    }


    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Failed to provide decoder with correct context")
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.id = try container.decode(Int.self, forKey: .id)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.title = try container.decode(String.self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MovieCodingKeys.self)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(id, forKey: .id)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(title, forKey: .title)
    }
}

extension MovieCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCD> {
        return NSFetchRequest<MovieCD>(entityName: "MovieCD")
    }

    @NSManaged public var backdropPath: String?
    @NSManaged public var id: Int
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var lastUpdated: String?
    @NSManaged public var category: String?
    @NSManaged public var movieDescription: MovieDescriptionCD?

    var cmpcategory: MovieType {
        get { MovieType(rawValue: category ?? "") ?? .popular }
        set { category = newValue.rawValue }
    }

}

extension MovieCD : Identifiable {

}
