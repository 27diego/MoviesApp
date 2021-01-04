//
//  PersonDetailsView.swift
//  TMDB
//
//  Created by Developer on 12/22/20.
//

import SwiftUI

struct PersonDetailsView: View {
    @ObservedObject var person: PersonDetailsVM
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Color.clear.overlay(
                    ZStack {
                        PosterCardView(imageUrl: person.profilePath)
                            .aspectRatio(contentMode: .fit)
                    }
                )
                .frame(width: 300, height: 300)
                .clipped()
                .cornerRadius(10)
                
//                Text(person.name)
//                    .font(.system(size: 50, weight: .bold, design: .rounded))
                
                VStack(spacing: 0) {
                    HStack {
                        Text("Known for")
                        Spacer()
                    }
                    .padding(.horizontal)
                    PersonMovieListView(movies: person.topMovies)
                }
                
                
                VStack(alignment: .leading, spacing:0) {
                    Text("Biography")
                        .padding()
                    Text(person.biography.prefix(250) + "...")
                        .padding(.horizontal)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("All Movies")
                        .padding()
                    PersonMovieListView(movies: person.movies)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Profile Images")
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 20) {
                            ForEach(person.images, id: \.self){ image in
                                PosterCardView(imageUrl: image.filePath)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 200, height: 200)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationBarTitle(person.name)
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(person: PersonDetailsVM(for: 90633))
    }
}

struct PersonMovieListView: View {
    var movies: [MovieModel]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(movies) { movie in
                    if movie.posterPath != nil {
                        NavigationLink(
                            destination: NavigationLazyView(MovieDetailsView(movieDetails: MovieDetailsVM(for: movie.id)))){
                            PosterCardView(imageUrl: movie.posterPath)
                                .frame(width: 110, height: 200)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
