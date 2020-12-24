//
//  MovieDetailsVM.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import Foundation
import Combine

class MovieDetailsVM: ObservableObject {
    @Published var id: Int = 0
    @Published var title: String = ""
    @Published var genres: [Genre] = []
    @Published var runtime: String?
    @Published var overview: String = ""
    @Published var popularity: Double = 0
    @Published var posterPath: String?
    @Published var backdropPath: String?
    @Published var releaseDate: String = ""
    @Published var actors: [Actor] = []
    @Published var crew: [CrewMember] = []
    
    var cancellable: AnyCancellable?
    
    init(for id: Int){
        setupData(for: id)
    }
    
    private func setupData(for id: Int){
        cancellable = Publishers.Zip(
            URLSession.shared.publisher(for: ItemEndpoint.getMovieDetails(for: id).url, responseType: MovieDetails.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovieCredits(for: id).url, responseType: MovieCreditResults.self)
        )
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: {
                self.id = $0.id
                self.title = $0.title
                self.genres = $0.genres
                self.runtime = $0.formattedRunTime
                self.overview = $0.overview
                self.popularity = $0.popularity
                self.posterPath = $0.posterPath
                self.backdropPath = $0.backdropPath
                self.releaseDate = $0.formattedReleaseDate
                self.actors = $1.cast
                self.crew = $1.crew
            })
    }
}
