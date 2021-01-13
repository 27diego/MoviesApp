//
//  MovieCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/12/21.
//
//

import Foundation
import CoreData

@objc(MovieCD)
public class MovieCD: NSManagedObject, Codable {
    enum CodingKeys: CodingKey {
        case backdropPath, id, overview, popularity, posterPath, releaseDate, title, movieDescription
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            fatalError("Attempt to decode managed object with misconfigured decoder.")
        }
        
        self.init(context: context)
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(title, forKey: .title)
        
    }
}
