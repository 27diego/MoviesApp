//
//  CategoryCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/15/21.
//
//

import Foundation
import CoreData

@objc(CategoryCD)
public class CategoryCD: NSManagedObject {

}

extension CategoryCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCD> {
        return NSFetchRequest<CategoryCD>(entityName: "CategoryCD")
    }

    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension CategoryCD {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieCD)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieCD)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension CategoryCD : Identifiable {

}

extension CategoryCD {
    static func findOrInsert(name: String, context: NSManagedObjectContext) -> CategoryCD {
        let request: NSFetchRequest<CategoryCD> = CategoryCD.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(CategoryCD.name), name)
        
        let results = try? context.fetch(request)
        
        if let first = results?.first {
            return first
        }
        
        let category = CategoryCD(context: context)
        category.name = name
        
        return category
    }
}
