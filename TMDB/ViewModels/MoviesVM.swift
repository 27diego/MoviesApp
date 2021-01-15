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
    @Published var people: [PersonModel] = []
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    let context = StorageProvider.shared.persistanceContainer.viewContext
    
    init(){
        initialSetup()
    }
    
    private func initialSetup(){
        let fetchRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        let results = try? context.fetch(fetchRequest)
        
        print(results?.count ?? -100)
        
        if let first = results?.first {
            if first.lastUpdated ?? "" < Date.getToday() {
                print("Im getting called where I check for last updated")
                fetchMovies()
            }
        }
        else if results?.count == 0 {
            print("Im getting called where I check for array size")
            fetchMovies()
        }
    }
    
    private func fetchMovies(){
        Publishers.Zip4(
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .popular).url, responseType: NetworkResponse<MovieCD>.self,context: context),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .nowPlaying).url, responseType: NetworkResponse<MovieCD>.self,context: context),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .topRated).url, responseType: NetworkResponse<MovieCD>.self,context: context),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .upcoming).url, responseType: NetworkResponse<MovieCD>.self,context: context)
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in}, receiveValue: { (popular, nowPlaying, topRated, upcoming) in
            self.assignMovies(movies: popular.results, category: "popular")
            self.assignMovies(movies: nowPlaying.results, category: "nowPlaying")
            self.assignMovies(movies: topRated.results, category: "topRated")
            self.assignMovies(movies: upcoming.results, category: "upcoming")
        })
        .store(in: &cancellables)
        
        URLSession.shared.publisher(for: ItemEndpoint.getPeople(from: .popular).url, responseType: NetworkResponse<PersonModel>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { self.people = $0.results })
            .store(in: &cancellables)
    }
    
    func assignMovies(movies: [MovieCD], category: String){
        movies.forEach { (item) in
            let movie = MovieCD.findOrInsert(id: item.identifier, context: context)
            movie.lastUpdated = Date.getToday()
            movie.category = category
            
            MovieCD.updateMovie(for: movie, values: item, context: context)
        }
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
