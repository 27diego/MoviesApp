//
//  ContentView.swift
//  TMDB
//
//  Created by Developer on 12/16/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movies: Movies = Movies()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                            .frame(width: 10)
                        Text("Upcoming")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Button("See all") {}
                        Spacer()
                            .frame(width: 10)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .center, spacing: 10) {
                            Spacer()
                                .frame(width: 1)
                            ForEach(movies.movies[.upcoming] ?? []){ movie in
                                SpotlightMovieCardView(movie: movie)
                            }
                            Spacer()
                                .frame(width: 1)
                        }
                    }
                }
            }
            .navigationTitle("Movie Hub")
        }
        .ignoresSafeArea()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
