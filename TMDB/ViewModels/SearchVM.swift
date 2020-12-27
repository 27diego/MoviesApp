//
//  SearchVM.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import Foundation
import Combine

class SearchVM: ObservableObject {
    @Published var searchQuery: String = "" {
        didSet {
            if searchQuery == "" {
                movieResults = []
            }
            if queryType == .movie {
                searchMovies()
            }
            else {
                searchPeople()
            }
        }
    }
    @Published var movieResults: [MovieModel] = []
    @Published var personResults: [PersonModel] = []
    @Published var placeholder: String = "Search"
    @Published var queryType: searchType = .movie
  
    
    @Published var totalPages: Int = 1
    
    var searchPlaceholders: [String] = [
        "Search for Popular Movies",
        "Search for Upcoming Movies",
        "Search for Actors",
        "Search \"Leonardo DiCaprio\"",
        "Search \"Gal Gadot\""
    ]
    var cancellables: Set<AnyCancellable> = .init()
    
    init(){
        startPlaceholders()
    }
    
    private func startPlaceholders(){
        Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { timer in
                self.placeholder = self.searchPlaceholders.randomElement() ?? "Search"
            }
            .store(in: &cancellables)
    }
    
    //how to make this generic
    func searchMovies(){
        URLSession.shared.publisher(for: ItemEndpoint.movieSearch(for: searchQuery).url, responseType: Search<MovieModel>.self)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in }, receiveValue: {
        self.movieResults = $0.results
        self.totalPages = $0.totalPages
        })
        .store(in: &cancellables)
    }
    
    func searchPeople(){
        URLSession.shared.publisher(for: ItemEndpoint.personSearch(for: searchQuery).url, responseType: Search<PersonModel>.self)
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { res in
            print("Results: \(res)")
        }, receiveValue: {
        self.personResults = $0.results
        self.totalPages = $0.totalPages
        })
        .store(in: &cancellables)
    }
    
}

enum searchType: String {
    case movie, actor
    
    var description: String {
        switch self {
        case .movie:
            return "Movies"
        case .actor:
            return "People"
        }
    }
}
