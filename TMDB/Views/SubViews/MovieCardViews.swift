//
//  MovieCardViews.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import SwiftUI

struct SpotlightCardView: View {
    var imageUrl: String?
    var title: String?
    var body: some View {
        Color.clear.overlay(
            Group {
                if imageUrl != nil{
                    RemoteImage(url: ImageEndpoint(path: imageUrl ?? "").url)
                        .overlay(
                            Group {
                                if title != nil {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear, Color.black.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
                                
                                        VStack(){
                                            Spacer()
                                            HStack {
                                                Text(title ?? "")
                                                    .font(.title2)
                                                    .bold()
                                                Spacer()
                                            }
                                        }
                                        .padding()
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                        )
                        .aspectRatio(contentMode: .fill)
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
        .clipped()
        .cornerRadius(10)
    }
}


struct SmallMoviePillView: View {
    var movie: MovieCD
    var body: some View {
        HStack(alignment: .top) {
            SpotlightCardView(imageUrl: movie.backdropPath)
                .frame(width: UIScreen.screenWidth * 0.45, height: 80)
            VStack(alignment: .leading) {
                Text(movie.title ?? "")
                    .foregroundColor(.black)
                    .font(.title3)
                    .bold()
                Spacer()
                    .frame(height: 15)
                Text(movie.formattedReleaseDate)
                    .font(.footnote)
                    .foregroundColor(Color(.systemGray))
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth * 0.84)
        .padding()
    }
}
