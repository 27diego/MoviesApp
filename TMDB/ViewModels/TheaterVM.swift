//
//  TheaterVM.swift
//  TMDB
//
//  Created by Developer on 12/29/20.
//q

import Foundation
import Combine

class Theater: ObservableObject {
    @Published var selectedSeats: [Seat] = .init()
    @Published var selectedDate: TicketDate = .init(day: "", month: "", year: "")
    @Published var selectedHourIndex: Int = -1
    
    var dates = Date.getFollowingThirtyDays()
}
