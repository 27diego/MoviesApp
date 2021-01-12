//
//  UserCD+CoreDataProperties.swift
//  TMDB
//
//  Created by Developer on 1/12/21.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var username: String?
    @NSManaged public var favoriteMovies: MovieCD?

}

extension UserCD : Identifiable {

}
