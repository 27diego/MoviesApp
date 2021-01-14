//
//  UserCD+CoreDataClass.swift
//  TMDB
//
//  Created by Developer on 1/14/21.
//
//

import Foundation
import CoreData

@objc(UserCD)
public class UserCD: NSManagedObject {
    
}



extension UserCD {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }
    
    @NSManaged public var username: String?
    
}

extension UserCD : Identifiable {
    
}
