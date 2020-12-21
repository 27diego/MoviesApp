//
//  MovieCardViews.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import SwiftUI

struct SpotlightMovieCardView: View {
    var movie: Movie
    var body: some View {
        Color.clear.overlay(
            Group {
                if movie.backdropPath != nil{
                    RemoteImage(url: ImageEndpoint(path: movie.backdropPath ?? "").url)
                        .overlay(
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear, Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                                
                                VStack(){
                                    Spacer()
                                    HStack {
                                        Text(movie.title)
                                            .font(.title2)
                                            .bold()
                                        Spacer()
                                    }
                                }
                                .padding()
                                .foregroundColor(.white)
                            }
                        )
                }
                else {
                    Rectangle()
                        .foregroundColor(Color(.systemGray5))
                        .overlay(
                            ProgressView()
                        )
                }
            }
        )
        .frame(width: UIScreen.screenWidth * 0.9, height: 200)
        .cornerRadius(10)
    }
}
