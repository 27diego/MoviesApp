//
//  MovieDetailsVM.swift
//  TMDB
//
//  Created by Developer on 12/21/20.
//

import Foundation
import Combine
import CoreData

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
    @Published var movieLinks: [MovieVideos] = []
    
    var cancellable: AnyCancellable?
    let context: NSManagedObjectContext = StorageProvider.shared.persistanceContainer.viewContext
    
    init(for id: Int){
        setupData(for: id)
    }
    
    private func check(for id: Int) {
        let request = MovieDescriptionCD.fetchDescriptionForMovie(id: id)
        if let _ = try? context.fetch(request).first {
            return
        }
        
        setupData(for: id)
    }
    
    private func setupData(for id: Int){
        cancellable = Publishers.Zip3(
            URLSession.shared.publisher(for: ItemEndpoint.getMovieDetails(for: id).url, responseType: MovieDetails.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovieCredits(for: id).url, responseType: MovieCreditResults.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMovieVideos(for: id).url, responseType: NetworkResponse<MovieVideos>.self)
        )
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: {
                let details = MovieDescriptionCD(context: self.context)
                details.identifier = $0.id
                details.title = $0.title
                details.runtime = $0.formattedRunTime
                details.overview = $0.overview
                details.popularity = $0.popularity
                details.backdropPath = $0.backdropPath
                details.posterPath = $0.posterPath
                details.releaseDate = $0.releaseDate
                $0.genres.forEach { item in
                    
                }
                
                self.genres = $0.genres
                self.actors = $1.cast
                self.crew = $1.crew
                self.movieLinks = $2.results.filter { res in res.site == "YouTube" }
                
                do{
                    try self.context.save()
                }
                catch{
                    print("couldn't save details to core data, \(error.localizedDescription)")
                }
            })
    }
}
