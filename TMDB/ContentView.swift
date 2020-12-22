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
                UpcomingSectionView(movies: movies.movies[.upcoming] ?? [])
                PopularSectionView(movies: movies.movies[.popular] ?? [])
                MovieGridSectionView(movies: movies.movies[.nowPlaying] ?? [])
                PopularPeopleSection(people: movies.people)
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
                            .frame(width: UIScreen.screenWidth * 0.9, height: 200)
                    }
                    Spacer()
                        .frame(width: 1)
                }
            }
        }
    }
}

struct PopularSectionView: View {
    var movies: [Movie]
    var body: some View {
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
                    ForEach(movies){ movie in
                        VStack(alignment: .leading) {
                            PosterCardView(imageUrl: movie.posterPath ?? "")
                                .frame(width: UIScreen.screenWidth * 0.45, height: 280)
                            
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
}

struct MovieGridSectionView: View {
    var movies: [Movie]
    var layout: [GridItem] = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("Now Playing")
                    .font(.title3)
                    .bold()
                Spacer()
                Button("See all") {}
                Spacer()
                    .frame(width: 10)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: layout){
                    ForEach(movies) { movie in
                        SmallMoviePillView(movie: movie)
                    }
                }
            }
        }
    }
}

struct PopularPeopleSection: View {
    var people: [PersonItem]
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("Actors")
                    .font(.title3)
                    .bold()
                Spacer()
                Button("See all") {}
                Spacer()
                    .frame(width: 10)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Spacer()
                        .frame(width: 10)
                    ForEach(people) { person in
                        if person.profilePath != nil {
                            VStack(alignment: .leading) {
                                PosterCardView(imageUrl: person.profilePath ?? "")
                                    .frame(width: UIScreen.screenWidth * 0.45, height: 250)
                                Text(person.name)
                                    .foregroundColor(Color.gray)
                                Text("\(person.popularity)")
                            }
                        }
                    }
                    Spacer()
                        .frame(width: 10)
                }
            }
        }
    }
}
