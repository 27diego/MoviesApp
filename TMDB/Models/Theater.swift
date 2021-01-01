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


struct TicketDate: Equatable, Identifiable {
    internal init(day: String, month: String, year: String) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    var day: String
    var month: String
    var year: String
    var id = UUID()
    
    var wholeDate: String {
        let components = DateComponents(year: Int(year), month: Int(month), day: Int(day))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = formatter.string(from: Calendar.current.date(from: components) ?? Date())
        return date
    }
}


struct TicketModel {
    var id = UUID()
    var movie: MovieModel
    var date: String
    var time: String
    var screen: Int
    var row: Int
    var seat: Int
    var price: Double
}
