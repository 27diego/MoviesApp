//
//  MovieDetails.swift
//  TMDB
//
//  Created by Developer on 12/17/20.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movie: MovieDetailsVM
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(for id: Int) {
        movie = MovieDetailsVM(for: id)
    }
    
    var body: some View {
        ScrollView {
            Color.clear.overlay(
                RemoteImage(url: movie.details?.posterImage ?? "")
                    .aspectRatio(contentMode: .fill)
            )
            .clipped()
            .overlay(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                    VStack(){
                        Spacer().frame(height: 20)
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "arrow.backward.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                            })
                            
                            
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .zIndex(10)
                }
            )
            .frame(height: 500)
            
            VStack(alignment: .leading, spacing: 20){
                Text(movie.details?.title ?? "No Movie Found :(")
                    .font(.title2)
                    .bold()
                HStack(alignment: .center){
                    ForEach(movie.details?.genres ?? [Genre]()) { genre in
                        Text(genre.name)
                        if movie.details?.genres.last != genre {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 5)
                        }
                    }
                    .font(.subheadline)
                }
                
                Text(movie.details?.overview ?? "")
                    .fixedSize(horizontal: false, vertical: true)
                
                VStack(alignment: .leading){
                    Text("Cast")
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(movie.actors){ actor in
                                PersonCircleView(image: actor.profileImage ?? "", name: actor.name)
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Director")
                    PersonCircleView(image: movie.director.first?.profileImage ?? "", name: movie.director.first?.name ?? "")
                }
                
                if movie.recommendations.count > 0 {
                    MoviePosterRow(movies: movie.recommendations, title: "Recomended Movies")
                }
            }
            .padding()
        }
        .background(Color.black)
        .foregroundColor(.white)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct PersonCircleView: View {
    var image: String
    var name: String
    var body: some View {
        VStack {
            Color.clear.overlay(
                RemoteImage(url: image)
                    .aspectRatio(contentMode: .fill)
            )
            .clipShape(Circle())
            .frame(width: 90, height: 90)
            
            Text(name)
                .font(.subheadline)
        }
    }
}
