//
//  GenresCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/15/21.
//
//

import Foundation
import CoreData

@objc(GenresCD)
public class GenresCD: NSManagedObject {

}

extension GenresCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenresCD> {
        return NSFetchRequest<GenresCD>(entityName: "GenresCD")
    }

    @NSManaged public var identifier: Int
    @NSManaged public var name: String?
    @NSManaged public var movie: NSSet?

}

// MARK: Generated accessors for movie
extension GenresCD {

    @objc(addMovieObject:)
    @NSManaged public func addToMovie(_ value: MovieDescriptionCD)

    @objc(removeMovieObject:)
    @NSManaged public func removeFromMovie(_ value: MovieDescriptionCD)

    @objc(addMovie:)
    @NSManaged public func addToMovie(_ values: NSSet)

    @objc(removeMovie:)
    @NSManaged public func removeFromMovie(_ values: NSSet)

}

extension GenresCD : Identifiable {
    
}

extension GenresCD {
    static func fetch(by id: Int) -> NSFetchRequest<GenresCD>{
        let request = NSFetchRequest<GenresCD>(entityName: "GenresCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(GenresCD.identifier), id as NSNumber)
        request.sortDescriptors = []
        
        return request
    }
    
    static func fetch(by genre: String) -> NSFetchRequest<GenresCD>{
        let request = NSFetchRequest<GenresCD>(entityName: "GenresCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(GenresCD.identifier), genre)
        request.sortDescriptors = []
        
        return request
    }
}

extension GenresCD {
    static func findOrInsert(by name: String, context: NSManagedObjectContext) -> GenresCD{
        let request = GenresCD.fetch(by: name)
        
        if let first = try? context.fetch(request).first {
            return first
        }
        
        let newGenre = GenresCD(context: context)
        newGenre.name = name
        
        return newGenre
    }
}
