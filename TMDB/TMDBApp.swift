//
//  TMDBApp.swift
//  TMDB
//
//  Created by Developer on 12/16/20.
//

import SwiftUI

@main
struct TMDBApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
