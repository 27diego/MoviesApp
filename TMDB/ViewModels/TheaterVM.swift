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
    @Published var selectedDate: [TicketDate] = .init()
}
