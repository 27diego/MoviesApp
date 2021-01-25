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
        checkMovies()
        checkPeople()
    }
    
    private func checkMovies(){
        let fetchRequest: NSFetchRequest<MovieCD> = MovieCD.fetchRequest()
        let results = try? context.fetch(fetchRequest)
                
        if let first = results?.first {
            if  Date.dateDifference(start: first.lastUpdated, end: Date()) > 1 {
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
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .popular).url, responseType: NetworkResponse<MovieModel>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .nowPlaying).url, responseType: NetworkResponse<MovieModel>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .topRated).url, responseType: NetworkResponse<MovieModel>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .upcoming).url, responseType: NetworkResponse<MovieModel>.self)
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in}, receiveValue: { (popular, nowPlaying, topRated, upcoming) in
            self.assignMovies(movies: popular.results, category: "popular")
            self.assignMovies(movies: nowPlaying.results, category: "nowPlaying")
            self.assignMovies(movies: topRated.results, category: "topRated")
            self.assignMovies(movies: upcoming.results, category: "upcoming")
        })
        .store(in: &cancellables)
    }
    
    func assignMovies(movies: [MovieModel], category: String){
        movies.forEach { (item) in
            let movie = MovieCD.findOrInsert(id: item.id, context: context)
            let category = CategoryCD.findOrInsert(name: category, context: context)
            movie.addToCategories(category)
            MovieCD.updateMovie(for: movie, values: item, context: context)
        }
    }
    
    private func checkPeople(){
        let request: NSFetchRequest<PersonCD> = PersonCD.fetchRequest()
        let results = try? context.fetch(request)
    
        if let first = results?.first {
            if first.lastUpdated ?? "" < Date.getToday() {
                print("calling fetch people yet again through first")
                fetchPeople()
            }
        }
        else if results?.count == 0{
            print("calling fetch people yet again through array size")
            fetchPeople()
        }
    }
    
    private func fetchPeople(){
        URLSession.shared.publisher(for: ItemEndpoint.getPeople(from: .popular).url, responseType: NetworkResponse<PersonModel>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { results in
                results.results.forEach { (person) in
                    let newPerson = PersonCD.findOrInsert(id: person.id, context: self.context)
                    newPerson.lastUpdated = Date.getToday()
                    newPerson.name = person.name
                    newPerson.popularity = person.popularity
                    newPerson.profilePath = person.profilePath
                    
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
    
    func deletePeople(){
        let request: NSFetchRequest<PersonCD> = PersonCD.fetchRequest()
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
