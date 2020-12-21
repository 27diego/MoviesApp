//
//  MoviesVM.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation
import Combine

class Movies: ObservableObject {
    @Published var movies: [MovieType:[Movie]] = [:]
    var cancellable: AnyCancellable?
    init(){
        initialSetup()
    }
    
    private func initialSetup(){
        cancellable = Publishers.Zip4(
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .popular).url, responseType: NetworkResponse<Movie>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .nowPlaying).url, responseType: NetworkResponse<Movie>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .topRated).url, responseType: NetworkResponse<Movie>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .upcoming).url, responseType: NetworkResponse<Movie>.self)
        )
            .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in}, receiveValue: { (popular, nowPlaying, topRated, upcoming) in
            self.movies[.popular] = popular.results
            self.movies[.nowPlaying] = nowPlaying.results
            self.movies[.topRated] = topRated.results
            self.movies[.upcoming] = upcoming.results
        })
    }
}
