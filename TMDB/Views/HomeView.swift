//
//  ContentView.swift
//  TMDB
//
//  Created by Developer on 12/16/20.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @ObservedObject var movies: Movies
    
    var body: some View {
        NavigationView {
            ScrollView {
//                BurnerView()
                UpcomingSectionView()
                PopularSectionView()
                MovieGridSectionView()
                PopularPeopleSection()
            }
            //            .navigationTitle("Movie Hub")
            .navigationBarItems(leading: HStack {
                Button("delete"){
                    movies.deleteMovies()
                    movies.deletePeople()
                }
            })
        }
        .edgesIgnoringSafeArea(.top)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(movies: Movies())
    }
}

//struct BurnerView: View {
//    @FetchRequest(entity: CategoryCD.entity(), sortDescriptors: [])
//    var results: FetchedResults<CategoryCD>
//
//    var body: some View {
//        List(results.first?.movies ?? NSSet()){ movie in
//
//        }
//    }
//}

struct UpcomingSectionView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(fetchRequest: MovieCD.fetchMovies(containing: "upcoming")) var movies: FetchedResults<MovieCD>
    
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("Upcoming")
                    .font(.title3)
                    .bold()
                Spacer()
                Button("See all") { showSheet.toggle() }
                Spacer()
                    .frame(width: 10)
            }
            .sheet(isPresented: $showSheet, content:{ SeeMoviesSheetView(movies: movies)
            })
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                        .frame(width: 1)
                    ForEach(movies){ movie in
                        NavigationLink(destination: MovieDetailsView(movieDetails: MovieDetailsVM(for: movie.identifier), id: movie.identifier)){
                            SpotlightCardView(imageUrl: movie.backdropPath ?? "", title: movie.title)
                        }
                        .isDetailLink(false)
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
    @FetchRequest(fetchRequest: MovieCD.fetchMovies(containing: "popular")) var movies: FetchedResults<MovieCD>
    
    
    @State var showSheet: Bool = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("Popular")
                    .font(.title3)
                    .bold()
                Spacer()
                Button("See all") { showSheet.toggle() }
                Spacer()
                    .frame(width: 10)
            }
            .sheet(isPresented: $showSheet, content:{ SeeMoviesSheetView(movies: movies)
            })
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .center, spacing: 10) {
                    Spacer()
                        .frame(width: 1)
                    ForEach(movies){ movie in
                        VStack(alignment: .leading) {
                            
                            NavigationLink(
                                destination: NavigationLazyView(MovieDetailsView(movieDetails: MovieDetailsVM(for: movie.identifier), id: movie.identifier))){
                                PosterCardView(imageUrl: movie.posterPath ?? "")
                            }
                            .frame(width: UIScreen.screenWidth * 0.45, height: 280)
                            
                            Text(movie.title ?? "")
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
    @FetchRequest(fetchRequest: MovieCD.fetchMovies(containing: "nowPlaying")) var movies: FetchedResults<MovieCD>
    
    @State var showSheet: Bool = false
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
                Button("See all") { showSheet.toggle() }
                Spacer()
                    .frame(width: 10)
            }
            .sheet(isPresented: $showSheet, content:{ SeeMoviesSheetView(movies: movies)
            })
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: layout){
                    ForEach(movies) { movie in
                        NavigationLink(
                            destination: NavigationLazyView(MovieDetailsView(movieDetails: MovieDetailsVM(for: movie.identifier), id: movie.identifier))){
                            SmallMoviePillView(movie: movie)
                        }
                    }
                }
            }
        }
    }
}

struct PopularPeopleSection: View {
    @FetchRequest(entity: PersonCD.entity(), sortDescriptors: [NSSortDescriptor(key: "popularity", ascending: false)])
    var people: FetchedResults<PersonCD>
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("Actors")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    Spacer()
                        .frame(width: 10)
                    ForEach(people) { person in
                        if person.profilePath != nil {
                            NavigationLink(
                                destination: NavigationLazyView(PersonDetailsView(person: PersonDetailsVM(for: person.identifier))),
                                label: {
                                    VStack(alignment: .leading) {
                                        PosterCardView(imageUrl: person.profilePath ?? "")
                                            .frame(width: UIScreen.screenWidth * 0.35, height: 200)
                                        Text(person.name)
                                            .foregroundColor(Color.gray)
                                    }
                                    .frame(width: UIScreen.screenWidth * 0.35)
                                    .clipped()
                                })
                            
                        }
                    }
                    Spacer()
                        .frame(width: 10)
                }
            }
        }
    }
}
