//
//  SeeMoviesSheetView.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import SwiftUI

struct SeeMoviesSheetView: View {
    var movies: [Movie]
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach(movies){ movie in
                    PresentationMovieCardView(posterPath: movie.posterPath ?? "", title: movie.title, overview: movie.overview)
                }
            }
            .padding()
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
