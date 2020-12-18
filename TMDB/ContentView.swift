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
                LazyVStack(spacing: 20){
                    MovieShowCaseRow(movies: movies.popularMovies)
                    MoviePosterRow(movies: movies.nowPlayingMovies, title: "Popular Movies")
                    MoviePosterRow(movies: movies.upComingMovies, title: "Upcoming Movies")
                    MoviePosterRow(movies: movies.topRatedMovies, title: "Top Rated Movies")
                }
                .navigationTitle("Movie Hub")
            }
        }
        .ignoresSafeArea()
    }
}

struct MovieShowCaseRow: View {
    var movies: [Movie]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                EdgeSpacer()
                ForEach(movies){ movie in
                    if movie.backDropImage != nil {
                        ShowcaseMovieCard(movie: movie)
                    }
                }
                EdgeSpacer()
            }
        }
    }
}



struct MoviePosterRow: View {
    var movies: [Movie]
    var title: String
    var body: some View {
        VStack(alignment: .leading) {
            LazyHStack {
                EdgeSpacer()
                Text(title)
                    .font(.title2)
                    .bold()
            }
            ScrollView(.horizontal){
                HStack{
                    EdgeSpacer()
                    ForEach(movies){ movie in
                        if movie.posterImage != nil {
                            MoviePosterView(movie: movie)
                        }
                    }
                    EdgeSpacer()
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
