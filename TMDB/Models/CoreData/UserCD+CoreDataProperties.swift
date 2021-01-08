//
//  UserCD+CoreDataProperties.swift
//  TMDB
//
//  Created by Developer on 1/7/21.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var username: String?

}

extension UserCD : Identifiable {

}
