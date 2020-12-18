//
//  MovieCards.swift
//  TMDB
//
//  Created by Developer on 12/17/20.
//

import SwiftUI

struct ShowcaseMovieCard: View {
    var movie: Movie
    var body: some View {
        NavigationLink(
            destination: MovieDetailsView(for: movie.id),
            label: {
                    Color.clear.overlay(
                        RemoteImage(url: movie.backDropImage!)
                            .aspectRatio(contentMode: .fill)
                    )
                    .clipped()
                    .overlay(
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                            VStack(alignment: .leading){
                                Spacer()
                                HStack {
                                    Text(movie.title)
                                        .foregroundColor(.white)
                                        .bold()
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                    )
                    .frame(width: 300, height: 200)
                    .cornerRadius(10)
            })
    }
}


struct MoviePosterView: View {
    var movie: Movie
    var body: some View {
        NavigationLink(
            destination: MovieDetailsView(for: movie.id),
            label: {
                Color.clear.overlay(
                    RemoteImage(url: movie.posterImage!)
                        .aspectRatio(contentMode: .fill)
                )
                .clipped()
                .cornerRadius(10)
                .frame(width: 150, height: 250)
            })
    }
}
