//
//  MoviesVM.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation
import Combine

class Movies: ObservableObject {
    @Published var movies: [MovieType:[MovieModel]] = [:]
    @Published var people: [PersonModel] = []
    
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(){
        initialSetup()
    }
    
    init(for type: MovieType){
        singleMoviesSetup(for: type)
    }
    
    private func initialSetup(){
        Publishers.Zip4(
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .popular).url, responseType: NetworkResponse<MovieModel>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .nowPlaying).url, responseType: NetworkResponse<MovieModel>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .topRated).url, responseType: NetworkResponse<MovieModel>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .upcoming).url, responseType: NetworkResponse<MovieModel>.self)
        )
            .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in}, receiveValue: { (popular, nowPlaying, topRated, upcoming) in
            self.movies[.popular] = popular.results
            self.movies[.nowPlaying] = nowPlaying.results
            self.movies[.topRated] = topRated.results
            self.movies[.upcoming] = upcoming.results
        })
        .store(in: &cancellables)
        
        URLSession.shared.publisher(for: ItemEndpoint.getPeople(from: .popular).url, responseType: NetworkResponse<PersonModel>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.people = $0.results })
            .store(in: &cancellables)            
    }
    
    private func singleMoviesSetup(for type: MovieType){
        URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: type).url, responseType: NetworkResponse<MovieModel>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.movies[type] = $0.results })
            .store(in: &cancellables)
    }
}
