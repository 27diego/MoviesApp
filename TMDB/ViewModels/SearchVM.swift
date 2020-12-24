//
//  SearchVM.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import Foundation
import Combine

class SearchVM: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchPlaceholders: [String] = [
        "Search \"Popular Movies\"",
        "Search \"Upcoming Movies\"",
        "Search \"Actors\"",
        "Search \"Leonardo DiCaprio\"",
        "Search \"Gal Gadot\""
    ]
    @Published var suggested: [MovieModel] = []
    @Published var upcomming: [MovieModel] = []
    
    var cancellables: Set<AnyCancellable> = .init()
    
    init(){
        setUp()
    }
    
    private func setUp(){
        Publishers.Zip(
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .popular).url, responseType: NetworkResponse<MovieModel>.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovies(from: .upcoming).url, responseType: NetworkResponse<MovieModel>.self)
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in }, receiveValue: {
            self.suggested = $0.results
            self.upcomming = $1.results
        })
        .store(in: &cancellables)
    }
    
}


enum searchType {
    
}
