//
//  DataImporter.swift
//  TMDB
//
//  Created by Developer on 1/12/21.
//

import Foundation
import CoreData

class DataImporter {
    private let context: NSManagedObjectContext
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func importData<T: NSManagedObject & Decodable>(_ data: Data, as model: T.Type) {
        context.perform { [unowned self] in
            let decoder = JSONDecoder()
            decoder.userInfo[.managedObjectContext] = self.context
            
            do{
                _ = try decoder.decode(model, from: data)
                try self.context.save()
            }
            catch {
                if self.context.hasChanges {
                    self.context.rollback()
                }
                
                print("Failed to insert models")
                print(error)
            }
        }
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

// Description
/*
 - Accept Data as its input
 - Decode Data to the appropriate model type
 - Persist the model to Core Data
 */
