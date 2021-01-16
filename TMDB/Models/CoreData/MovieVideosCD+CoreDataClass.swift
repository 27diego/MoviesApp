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

}

extension MovieVideosCD : Identifiable {

}
