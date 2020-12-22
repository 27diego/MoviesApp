//
//  Person.swift
//  TMDB
//
//  Created by Developer on 12/20/20.
//

import Foundation

// MARK: - maybe should be a struct?
protocol Person {
    var id: Int { get }
    var name: String { get }
    var profilePath: String? { get  }
}

struct PersonItem: Codable, Identifiable, Person {
    var id: Int
    var name: String
    var profilePath: String?
    var popularity: Double
}

struct Actor: Codable, Identifiable, Person {
    var id: Int
    var name: String
    var profilePath: String?
    var order: Int
    var popularity: Double
    var character: String
}

struct CrewMember: Codable, Identifiable, Person {
    var id: Int
    var name: String
    var profilePath: String?
    var department: String
    var job: String
}

struct PersonDetails: Codable {
    let id: Int
    let name: String
    let birthday: String
    let biography: String
    let popularity: Double
    let placeOfBirth: String
    let profilePath: String?
}

enum PersonType {
    case popular
    
    var description: String {
        switch self {
        case .popular:
            return "person/popular"
        }
    }
}
