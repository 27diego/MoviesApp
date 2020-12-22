//
//  MovieDetailsView.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movieDetails: MovieDetailsVM
    init(for id: Int){
        movieDetails = MovieDetailsVM(for: id)
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Color.clear.overlay(
                    Group{
                        if movieDetails.backdropPath != nil {
                            RemoteImage(url: ImageEndpoint(path: movieDetails.posterPath ?? "").url)
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 400 ,alignment: .top)
                        }
                        else{
                            ProgressView()
                        }
                    }
                )
                .frame(height: 400)
                .clipped()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(movieDetails.title)
                        .font(.title)
                        .bold()
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(movieDetails.genres) { genre in
                                Text(genre.name)
                                    .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.5098039216, blue: 0.5254901961, alpha: 1)))
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 5)
                                    .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9647058824, alpha: 1)))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    
                    HStack{
                        Text(movieDetails.releaseDate)
                        Spacer()
                        Text(movieDetails.runtime ?? "")
                    }
                    .foregroundColor(Color(.systemGray))
                    
                    Text(movieDetails.overview)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 10)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}
