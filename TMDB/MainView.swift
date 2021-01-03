//
//  MainView.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        // MARK: - customize tabview
        TabView {
            HomeView(movies: Movies())
                .tabItem {
                    VStack{
                        Image(systemName: "house.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Text("House")
                    }
                }
            SearchView(search: SearchVM())
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        Text("Search")
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
