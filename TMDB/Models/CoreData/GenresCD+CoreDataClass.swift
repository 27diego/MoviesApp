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

    @NSManaged public var identifier: Int64
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
