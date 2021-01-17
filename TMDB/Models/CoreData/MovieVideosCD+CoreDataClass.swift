//
//  MovieVideosCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/15/21.
//
//

import Foundation
import CoreData

@objc(MovieVideosCD)
public class MovieVideosCD: NSManagedObject {

}

extension MovieVideosCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieVideosCD> {
        return NSFetchRequest<MovieVideosCD>(entityName: "MovieVideosCD")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var key: String?
    @NSManaged public var name: String?
    @NSManaged public var site: String?
    @NSManaged public var movie: MovieDescriptionCD?
    
    var youtubeUrl: String? {
        return "https://youtube.com/watch?v=\(self.key!)"
    }

}

extension MovieVideosCD : Identifiable {

}

extension MovieVideosCD {
    static func fetch(by id: String) -> NSFetchRequest<MovieVideosCD> {
        let request = NSFetchRequest<MovieVideosCD>(entityName: "MovieVideosCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(MovieVideosCD.identifier), id)
        request.sortDescriptors = []
        
        return request
    }
}

extension MovieVideosCD {
    static func findOrInsert(by id: String, context: NSManagedObjectContext) -> MovieVideosCD{
        let request = MovieVideosCD.fetch(by: id)
        
        if let first = try? context.fetch(request).first {
            return first
        }
        
        let newLink = MovieVideosCD(context: context)
        newLink.identifier = id
        
        return newLink
    }
}
