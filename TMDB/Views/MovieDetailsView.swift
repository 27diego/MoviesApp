//
//  MovieDetailsView.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movieDetails: MovieDetailsVM
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(for id: Int){
        movieDetails = MovieDetailsVM(for: id)
    }
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        })
                        Spacer()
                    }
                    .padding(30)
                    .padding(.top, 20)
                    Spacer()
                }
                .zIndex(2)
                
                VStack(alignment: .center, spacing: 20) {
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
                    
                    VStack(alignment: .leading) {
                        Text("Actors")
                            .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                Spacer()
                                    .frame(width: 10)
                                ForEach(movieDetails.actors) { actor in
                                    NavigationLink(
                                        destination: NavigationLazyView(PersonDetailsView(for: actor.id)),
                                        label: {
                                            VStack(alignment: .leading){
                                                PosterCardView(imageUrl: actor.profilePath)
                                                    .frame(width: UIScreen.screenWidth * 0.35, height: 200)
                                                    .aspectRatio(contentMode: .fill)
                                                
                                                Text(actor.name)
                                            }
                                            .foregroundColor(.black)
                                        })
                                }
                                Spacer()
                                    .frame(width: 10)
                            }
                        }
                    }
                    
                    NavigationLink(
                        destination: NavigationLazyView(TheaterView(selectedSeats: .constant([]))),
                        label: {
                          Text("Reserve Seats")
                        })
                        .buttonStyle(CustomButtonStyle(color: Color(#colorLiteral(red: 0.5490196078, green: 0.3098039216, blue: 0.9529411765, alpha: 1))))
                        .frame(width: UIScreen.screenWidth * 0.9)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
