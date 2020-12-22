//
//  MovieDetailsView.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import SwiftUI

struct MovieDetailsView: View {
    var movieDetails: MovieDetails = MovieDetails(id: 464052, title: "Wonder Woman 1984", genres: [Genre(id: 1, name: "Action"), Genre(id: 2, name: "Adventure"), Genre(id: 3, name: "Fantasy")], runtime: 151, overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.", popularity: 1108.499, posterPath: "/di1bCAfGoJ0BzNEavLsPyxQ2AaB.jpg", backdropPath: "/8AQRfTuTHeFTddZN4IUAqprN8Od.jpg")
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView()
    }
}
