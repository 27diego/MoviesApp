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
                        
                        ScrollView(.horizontal, showsIndicators: false) {
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
                        
                        Text("Storyline")
                            .font(.title3)
                            .bold()
                        
                        Text(movieDetails.overview)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Actors")
                            .padding(.horizontal)
                        CirclePeopleSectionView(people: movieDetails.actors)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Crew")
                            .padding(.horizontal)
                        CirclePeopleSectionView(people: movieDetails.crew)
                    }
                    
                    NavigationLink(
                        destination: NavigationLazyView(TheaterView(for: MovieModel(id: movieDetails.id, title: movieDetails.title, popularity: movieDetails.popularity, releaseDate: movieDetails.releaseDate, backdropPath: movieDetails.backdropPath, posterPath: movieDetails.posterPath, overview: movieDetails.overview))),
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

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(for: 100)
    }
}

struct CirclePeopleSectionView<T: Person>: View {
    var people: [T]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Spacer()
                    .frame(width: 10)
                ForEach(people) { person in
                    if person.profilePath != nil {
                        NavigationLink(
                            destination: NavigationLazyView(PersonDetailsView(for: person.id)),
                            label: {
                                VStack {
                                    RemoteImage(url: ImageEndpoint(path: person.profilePath ?? "").url)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                    Text(person.name)
                                        .frame(width: 100)
                                        .clipped()
                                    
                                }
                                .foregroundColor(.black)
                            })
                    }
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}
