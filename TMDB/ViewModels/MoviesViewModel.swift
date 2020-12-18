//
//  MovieVM.swift
//  TMDB
//
//  Created by Developer on 12/16/20.
//

import Foundation
import Combine

class Movies: ObservableObject {
    @Published var popularMovies: [Movie] = [Movie]()
    @Published var upComingMovies: [Movie] = [Movie]()
    @Published var topRatedMovies: [Movie] = [Movie]()
    @Published var nowPlayingMovies: [Movie] = [Movie]()
    
    var cancellables = Set<AnyCancellable>()
    
    init(){
       setUpData()
    }
     
    private func setUpData() {
        getMovies(of: .popularMovies)
            .sink(receiveCompletion: {_ in}, receiveValue: {data in
                self.popularMovies = data.results
            })
            .store(in: &cancellables)
        
        getMovies(of: .upcomingMovies)
            .sink(receiveCompletion: {_ in}, receiveValue: {data in
                self.upComingMovies = data.results
            })
            .store(in: &cancellables)
        
        getMovies(of: .topRatedMovies)
            .sink(receiveCompletion: {_ in}, receiveValue: {data in
                self.topRatedMovies = data.results
            })
            .store(in: &cancellables)
        
        getMovies(of: .nowPlaying)
            .sink(receiveCompletion: {_ in}, receiveValue: {data in
                self.nowPlayingMovies = data.results
            })
            .store(in: &cancellables)
    }
    
    private func getMovies(of type: MovieTypes) -> Publishers.ReceiveOn<Publishers.Decode<Publishers.Map<URLSession.DataTaskPublisher, Data>, MovieResults, JSONDecoder>, DispatchQueue>{
        var components = Utils.URLcomponents
        components.path = "/3/\(type.description)"
        let session = URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: MovieResults.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        
        return session
    }
}



//        URLSession.shared.dataTaskPublisher(for: components.url!)
//            .map { $0.data }
//            .decode(type: MovieResults.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in }, receiveValue: { data in
//                self.movies = data.results
//            })
//            .store(in: &cancellables)
