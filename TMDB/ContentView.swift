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
                VStack(spacing: 20) {
                    UpcomingSectionView(movies: movies.movies[.upcoming] ?? [])
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width: 10)
                            Text("Popular")
                                .font(.title3)
                                .bold()
                            Spacer()
                            Button("See all") {}
                            Spacer()
                                .frame(width: 10)
                        }
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(alignment: .center, spacing: 10) {
                                Spacer()
                                    .frame(width: 1)
                                ForEach(movies.movies[.popular] ?? []){ movie in
                                    VStack(alignment: .leading) {
                                        PosterCardView(imageUrl: movie.posterPath ?? "")
                                        
                                        Text(movie.title)
                                            .foregroundColor(Color.gray)
                                    }
                                    .frame(width: UIScreen.screenWidth * 0.45)
                                    .clipped()
                                }
                                Spacer()
                                    .frame(width: 10)
                            }
                        }
                    }
                }
                .navigationTitle("Movie Hub")
            }
        }
        .ignoresSafeArea()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UpcomingSectionView: View {
    var movies: [Movie]
    var body: some View {
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
                    ForEach(movies){ movie in
                        SpotlightCardView(imageUrl: movie.backdropPath ?? "", title: movie.title)
                    }
                    Spacer()
                        .frame(width: 1)
                }
            }
        }
    }
}
