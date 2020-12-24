//
//  Theater.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import Foundation

struct Seat: Identifiable {
    internal init(id: UUID, row: Int, number: Int) {
        self.id = id
        self.row = row
        self.number = number
    }
    
    let id: UUID
    let row: Int
    let number: Int
}


struct TicketDate: Equatable {
    internal init(day: String, month: String, year: String) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    var day: String
    var month: String
    var year: String
}
