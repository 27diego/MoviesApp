//
//  MoviesVM.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation
import Combine
import CoreData

class Movies: ObservableObject {
    @Published var movies: [MovieType:[MovieModel]] = [:]
    @Published var people: [PersonModel] = []
    var times: Int = 0
    
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    let context = StorageProvider.shared.persistanceContainer.viewContext
    
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
    
    func addMovies(){
        times = times+1
        URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .popular).url, responseType: NetworkResponse<MovieCD>.self, context: self.context)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}, receiveValue: {popular in
                print("Calling request \(self.times) times")
                popular.results.forEach { item in
                    let movie = MovieCD(context: self.context)
                    movie.id = item.id
                    movie.title = item.title
                    movie.backdropPath = item.backdropPath
                    movie.popularity = item.popularity
                    movie.posterPath = item.posterPath
                    movie.overview = item.overview
                    movie.releaseDate = item.releaseDate
                    movie.cmpcategory = .popular
                    movie.lastUpdated = Date.getToday()
                    
                    do {
                        try self.context.save()
                    }
                    catch {
                        if self.context.hasChanges {
                            self.context.rollback()
                        }
                        print("couldn't save to core data: \(error.localizedDescription)")
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func deleteMovies(){
        let request: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        let movies = try! self.context.fetch(request)
        
        movies.forEach { movie in
            do {
                context.delete(movie)
                try context.save()
            }
            catch {
                if self.context.hasChanges {
                    self.context.rollback()
                }
                print("couldn't delete from core data: \(error.localizedDescription)")
            }
        }
        
    }
}
