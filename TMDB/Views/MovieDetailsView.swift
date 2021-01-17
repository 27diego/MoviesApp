//
//  MovieDetailsView.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import SwiftUI
import AVKit

struct MovieDetailsView: View {
    @ObservedObject var movieDetails: MovieDetailsVM
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showSheet: Bool = false
    @FetchRequest var details: FetchedResults<MovieDescriptionCD>
    
    init(movieDetails: MovieDetailsVM, id: Int){
        self._movieDetails = ObservedObject(wrappedValue: movieDetails)
        self._details = FetchRequest(fetchRequest: MovieDescriptionCD.fetchDescriptionForMovie(id: id))
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
                            if details.first?.backdropPath != nil {
                                RemoteImage(url: ImageEndpoint(path: details.first?.posterPath ?? "").url)
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
                        Text(details.first?.title ?? "")
                            .font(.title)
                            .bold()
                        
                        GenresListView(genres: details.first?.genres ?? Set<GenresCD>())
                        
                        HStack{
                            Text(details.first?.releaseDate ?? "")
                            Spacer()
                            Text(details.first?.runtime ?? "")
                        }
                        .foregroundColor(Color(.systemGray))
                        Text("\(details.count)")
                        Text("Storyline")
                            .font(.title3)
                            .bold()
                        
                        Text(details.first?.overview ?? "")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Actors")
                            .padding(.horizontal)
                        CirclePeopleSectionView(people: details.first?.actors ?? Set<ActorCD>())
                    }

                    VStack(alignment: .leading) {
                        Text("Crew")
                            .padding(.horizontal)
                        CirclePeopleSectionView(people: details.first?.crewMembers ?? Set<CrewMemberCD>())
                    }
//                    
//                    VStack(alignment: .leading){
//                        Text("Trailers")
//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack {
//                                ForEach(details.first?.getLinks){ link in
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .frame(width: 200, height: 50)
//                                        .foregroundColor(Color(.systemGray6))
//                                        .overlay(
//                                            Text(link.name)
//                                                .onTapGesture {
//                                                    showSheet.toggle()
//                                                }
//                                                .sheet(isPresented: $showSheet){
//                                                    SafariView(url: URL(string: link.youtubeUrl ?? "")!)
//                                                }
//                                                .padding()
//                                        )
//                                }
//                            }
//                        }
//                    }.padding()
                    
//                    NavigationLink(
//                        destination: NavigationLazyView(TheaterView(theater: TheaterVM(for: MovieModel(id: movieDetails.id, title: movieDetails.title, popularity: movieDetails.popularity, releaseDate: movieDetails.releaseDate, backdropPath: movieDetails.backdropPath, posterPath: movieDetails.posterPath, overview: movieDetails.overview))))){
//                        Text("Reserve Seats")
//                    }
//                    .buttonStyle(CustomButtonStyle(color: Color(#colorLiteral(red: 0.5490196078, green: 0.3098039216, blue: 0.9529411765, alpha: 1))))
//                    .frame(width: UIScreen.screenWidth * 0.9)
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
        MovieDetailsView(movieDetails: MovieDetailsVM(for: 464052), id: 464052)
    }
}




/*
 
 Video Player:
 
 VideoPlayer(player: AVPlayer(url: URL(string: link.youtubeUrl ?? "")!)) {
 Text(link.name)
 }
 .aspectRatio(contentMode: .fit)
 .frame(width: 100, height: 100)
 */

struct GenresListView: View {
    var genres: Set<GenresCD>
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Array(genres), id: \.self) { genre in
                    Text(genre.name ?? "")
                        .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.5098039216, blue: 0.5254901961, alpha: 1)))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 5)
                        .background(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9647058824, alpha: 1)))
                        .clipShape(Capsule())
                }
            }
        }
    }
}
