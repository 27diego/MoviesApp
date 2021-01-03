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
    @State var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            Group {
                if !isLoggedIn {
                    SignInView(auth: SignInVM(), isLoggedIn: $isLoggedIn)
                }
                else {
                    MainView()
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
