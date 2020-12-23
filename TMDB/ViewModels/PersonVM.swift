//
//  PersonVM.swift
//  TMDB
//
//  Created by Developer on 12/22/20.
//

import Foundation
import Combine

class PersonDetailsVM: ObservableObject {
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var birthday: String = ""
    @Published var biography: String = ""
    @Published var popularity: Double = 0.0
    @Published var placeOfBirth: String = ""
    @Published var profilePath: String?
    @Published var movies: [Movie] = []
    @Published var images: [PersonImages] = []
    
    var topMovies: [Movie] {
        Array(movies.prefix(3))
    }
    
    var cancellables = Set<AnyCancellable>()
    
    init(for id: Int) {
        setUpData(for: id)
    }
    
    private func setUpData(for id: Int){
        Publishers.Zip3(
            URLSession.shared.publisher(for: ItemEndpoint.getPerson(for: id).url, responseType: PersonDetails.self),
            URLSession.shared.publisher(for: ItemEndpoint.getMoviesForPerson(for: id).url, responseType: PersonCreditResults.self),
            URLSession.shared.publisher(for: ItemEndpoint.getImagesForPerson(for: id).url, responseType: PersonImagesResults.self)
            )
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                print("Recieved: \(value)")
            }, receiveValue: {
                self.id = $0.id
                self.name = $0.name
                self.birthday = $0.birthday
                self.biography = $0.biography
                self.popularity = $0.popularity
                self.placeOfBirth = $0.placeOfBirth
                self.profilePath = $0.profilePath
                self.movies = $1.cast.sorted { $0.popularity > $1.popularity }
                self.images = $2.profiles
                
            })
        .store(in: &cancellables)
    }
    
}
