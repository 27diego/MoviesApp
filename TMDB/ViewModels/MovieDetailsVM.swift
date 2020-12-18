//
//  MovieDescriptionVM.swift
//  TMDB
//
//  Created by Developer on 12/17/20.
//

import Foundation
import Combine

class MovieDetailsVM: ObservableObject{
    @Published var details: MovieDetails?
    @Published var crew: [Crew] = [Crew]()
    @Published var cast: [Cast] = [Cast]()
    @Published var recommendations: [Movie] = [Movie]()
    var cancellables = Set<AnyCancellable>()
    
    init(for id: Int){
        setUpData(for: id)
    }
    
    var director: [Crew] {
        crew.filter { $0.job == "Director" }
    }
    
    var actors: [Cast] {
        cast.filter { $0.profileImage != nil }
    }
    
    func setUpData(for id: Int){
        var movieDetailsComponents = Utils.URLcomponents
        movieDetailsComponents.path = "/3/movie/\(id)"
        URLSession.shared.dataTaskPublisher(for: movieDetailsComponents.url!)
            .map { $0.data }
            .decode(type: MovieDetails.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in}, receiveValue: {data in
                self.details = data
            })
            .store(in: &cancellables)

        var movieCreditsComponents = Utils.URLcomponents
        movieCreditsComponents.path = "/3/movie/\(id)/credits"
//        print("URL: ", movieCreditsComponents.string!)
        URLSession.shared.dataTaskPublisher(for: movieCreditsComponents.url!)
            .map { $0.data }
            .decode(type: MovieCredits.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in}, receiveValue: {data in
//                print("data: \(data)")
                self.crew = data.crew
                self.cast = data.cast
            })
            .store(in: &cancellables)
        
        var relatedMoviesComponents = Utils.URLcomponents
        relatedMoviesComponents.path = "/3/movie/\(id)/recommendations"
        URLSession.shared.dataTaskPublisher(for: relatedMoviesComponents.url!)
            .map { $0.data }
            .decode(type: RecommendedMovies.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in}, receiveValue: { data in
                self.recommendations = data.results
            })
            .store(in: &cancellables)
    }
}
