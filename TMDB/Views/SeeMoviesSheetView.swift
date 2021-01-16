//
//  SeeMoviesSheetView.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import SwiftUI

struct SeeMoviesSheetView: View {
    var movies: FetchedResults<MovieCD>
    @Namespace var nspace
    @State var present: Bool = false
    @State var id: Int = 0
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(movies){ movie in
                        // TODO: - Hero Animation
                        NavigationLink(
                            destination: NavigationLazyView(MovieDetailsView(movieDetails: MovieDetailsVM(for: movie.identifier), id: movie.identifier)),
                            label: {
                                PresentationMovieCardView(posterPath: movie.posterPath ?? "", title: movie.title ?? "", overview: movie.overview ?? "")
                                    .foregroundColor(.black)
                            })
                    }
                }
                .padding()
            }
            .navigationTitle("Upcoming Movies")
        }
    }
}


struct PresentationMovieCardView: View {
    var posterPath: String
    var title: String
    var overview: String
    var body: some View {
        Color.clear.overlay(
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    RemoteImage(url: ImageEndpoint(path: posterPath).url)
                        .aspectRatio(contentMode: .fill)
                        .frame(height: geo.size.height*0.7, alignment: .top)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(title)
                            .font(.title)
                            .bold()
                        
                        Text(overview)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                }
            }
        )
        .background(Color.white)
        .frame(height: 350)
        .clipped()
        .cornerRadius(10)
        .shadow(radius: 20)
        
    }
}
