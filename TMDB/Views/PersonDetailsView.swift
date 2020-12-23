//
//  PersonDetailsView.swift
//  TMDB
//
//  Created by Developer on 12/22/20.
//

import SwiftUI

struct PersonDetailsView: View {
    @ObservedObject var person: PersonDetailsVM
    init(for id: Int){
        person = PersonDetailsVM(for: id)
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Color.clear.overlay(
                    ZStack {
                        PosterCardView(imageUrl: person.profilePath)
                            .aspectRatio(contentMode: .fit)
                    }
                )
                .frame(width: 300, height: 300)
                .clipped()
                .cornerRadius(10)
                
                Text(person.name)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                
                Text("Known for")
                
                ScrollView(.horizontal){
                    HStack {
                        ForEach(person.topMovies) { movie in
                            PosterCardView(imageUrl: movie.posterPath)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 200)
                        }
                    }
                }
            }
        }
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(for: 90633)
    }
}
