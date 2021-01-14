//
//  TMDBApp.swift
//  TMDB
//
//  Created by Developer on 12/16/20.
//

import SwiftUI
import CoreData

@main
struct TMDBApp: App {
    let persistenceController: StorageProvider
    let context: NSManagedObjectContext
    @State var isLoggedIn: Bool = false
    
    init(){
        persistenceController = StorageProvider.shared
        context = persistenceController.persistanceContainer.viewContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    var body: some Scene {
        WindowGroup {
//            Group {
//                if !isLoggedIn {
//                    SignInView(auth: SignInVM(), isLoggedIn: $isLoggedIn)
//                }
//                else {
                    MainView()
//                }
//            }
            .environment(\.managedObjectContext, context)
        }
    }
}
