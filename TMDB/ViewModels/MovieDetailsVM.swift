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
    let storageProvider = StorageProvider.shared
    
    init(for id: Int){
       check(for: id)
    }
    
    private func check(for id: Int) {
        let request = MovieDescriptionCD.fetchDescriptionForMovie(id: id)
        if let first = try? context.fetch(request).first {
            if first.lastUpdated! < Date.getToday() {
                setupData(for: id)
            }
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
                let details = MovieDescriptionCD.findOrInsert(with: id, context: self.context)
                details.title = $0.title
                details.runtime = $0.formattedRunTime
                details.overview = $0.overview
                details.popularity = $0.popularity
                details.backdropPath = $0.backdropPath
                details.posterPath = $0.posterPath
                details.releaseDate = $0.releaseDate
                details.lastUpdated = Date.getToday()
                $0.genres.forEach { item in
                    let genre = GenresCD.findOrInsert(by: item.name, context: self.context)
                    genre.identifier = item.id
                    details.addToGenres(genre)
                }
                
                $1.cast.forEach { item in
                    let actor = ActorCD.findOrInsert(id: item.id, context: self.context)
                    actor.character = item.character
                    actor.name = item.name
                    actor.profilePath = item.profilePath
                    actor.order = item.order
                    actor.popularity = item.popularity
                    actor.lastUpdated = Date.getToday()
                    details.addToActors(actor)
                }
                $1.crew.forEach { item in
                    let crewMember = CrewMemberCD.findOrInsert(by: item.id, context: self.context)
                    crewMember.department = item.department
                    crewMember.job = item.job
                    crewMember.name = item.name
                    crewMember.profilePath = item.profilePath
                    crewMember.lastUpdated = Date.getToday()
                    details.addToCrewMembers(crewMember)
                }
                $2.results.filter { res in res.site == "YouTube" }.forEach { item in
                    let link = MovieVideosCD.findOrInsert(by: item.id, context: self.context)
                    link.key = item.key
                    link.name = item.name
                    link.site = item.site
                    self.storageProvider.saveContext(context: self.context)
                    details.addToMovieLinks(link)
                }
                
                self.storageProvider.saveContext(context: self.context)
            })
    }
}
