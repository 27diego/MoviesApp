//
//  MovieCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/15/21.
//
//

import Foundation
import CoreData

@objc(MovieCD)
public class MovieCD: NSManagedObject, Codable {
    enum MovieCodingKeys: String, CodingKey {
        case backdropPath, identifier = "id", overview, popularity, posterPath, releaseDate, title, lastUpdated, movieDescription
    }


    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Failed to provide decoder with correct context")
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.identifier = try container.decode(Int.self, forKey: .identifier)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.title = try container.decode(String.self, forKey: .title)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: MovieCodingKeys.self)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(identifier, forKey: .identifier)
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
    @NSManaged public var identifier: Int
    @NSManaged public var lastUpdated: Date
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var movieDescription: MovieDescriptionCD?
    @NSManaged public var categories: NSSet?
    
    var formattedReleaseDate: String {
            if let release = releaseDate{
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd"

                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MMMM d, yyyy"

                let date: Date? = dateFormatterGet.date(from: release)
                return dateFormatterPrint.string(from: date!)
            }
            return ""
        }

}

// MARK: Generated accessors for categories
extension MovieCD {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CategoryCD)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CategoryCD)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension MovieCD : Identifiable {

}

// MARK: - Fetch Requests extension
extension MovieCD {
    static func fetchMovie(id: Int) -> NSFetchRequest<MovieCD> {
        let request = NSFetchRequest<MovieCD>(entityName: "MovieCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieCD.identifier), id as NSNumber)
        
        return request
    }
    
    static func fetchMovies(containing category: String) -> NSFetchRequest<MovieCD> {
        let request = NSFetchRequest<MovieCD>(entityName: "MovieCD")
        request.predicate = NSPredicate(format: "ANY categories.name ==[c] %@", category)
        request.sortDescriptors = [NSSortDescriptor(key: "popularity", ascending: false), NSSortDescriptor(key: "releaseDate", ascending: false)]
        request.fetchLimit = 10
        
        return request
    }
}


// MARK: - Static functions extension
extension MovieCD {
    static func findOrInsert(id: Int, context: NSManagedObjectContext) -> MovieCD {
        let request = MovieCD.fetchMovie(id: id)
        
        if let result = try? context.fetch(request).first {
            print("found result")
            return result
        }
        
        let newMovie = MovieCD(context: context)
        newMovie.identifier = id

        return newMovie
    }
    
    static func updateMovie(for movie: MovieCD, values: MovieModel, context: NSManagedObjectContext){
        movie.backdropPath = values.backdropPath
        movie.overview = values.overview
        movie.popularity = values.popularity
        movie.posterPath = values.posterPath
        movie.releaseDate = values.releaseDate
        movie.title = values.title
        movie.lastUpdated = Date()
            
        do {
            try context.save()
        } catch  {
            print("could not save to core data with updating: \(error.localizedDescription)")
            if context.hasChanges {
                context.rollback()
            }
        }
    }
}
