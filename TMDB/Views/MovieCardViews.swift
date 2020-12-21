//
//  MovieCardViews.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import SwiftUI

struct SpotlightCardView: View {
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
        .clipped()
        .cornerRadius(10)
    }
}


struct PosterCardView: View {
    var imageUrl: String?
    var body: some View {
        Color.clear.overlay(
            Group {
                if imageUrl != nil{
                    RemoteImage(url: ImageEndpoint(path: imageUrl ?? "").url)
                        .aspectRatio(contentMode: .fill)
                } else {
                    Rectangle()
                        .foregroundColor(Color(.systemGray5))
                        .overlay(
                            ProgressView()
                        )
                }
            }
        )
        .frame(width: UIScreen.screenWidth * 0.45, height: 280)
        .clipped()
        .cornerRadius(10)
    }
}
