//
//  TheaterVM.swift
//  TMDB
//
//  Created by Developer on 12/29/20.
//q

import Foundation
import Combine

class TheaterVM: ObservableObject {
    @Published var selectedSeats: [Seat] = .init()
    @Published var selectedDate: TicketDate = .init(day: "", month: "", year: "")
    @Published var selectedHour: String = ""
    @Published var continueButton: Bool = false
    
    var movie: MovieModel
    var dates: [TicketDate] = Date.getFollowingThirtyDays()
    var hours: [String] = Date.getRemainingHours()
    var cancellables: Set<AnyCancellable> = .init()
    
    init(for movie: MovieModel){
        self.movie = movie
        setUpPublishers()
    }
    
    func setUpPublishers() {        
        Publishers.CombineLatest3($selectedSeats, $selectedDate, $selectedHour)
            .map { seats, date, hour -> Bool in
                if seats.count > 0 && seats.count < 5 && date.day != "" && hour != ""  {
                    return false
                }
                
                return true
            }
            .assign(to: &$continueButton)
    }
    
    func selectDate(date: TicketDate) {
        if date == selectedDate {
            selectedDate = TicketDate.init(day: "", month: "", year: "")
        }
        else {
            selectedDate = date
        }
    }
    func selectHour(hour: String) {
        if selectedHour == hour {
            selectedHour = ""
        }
        else {
            selectedHour = hour
        }
    }
    
    func getTickets() -> [TicketModel] {
        var tickets: [TicketModel] = .init()
        
        for seat in self.selectedSeats {
            tickets.append(TicketModel(movie: self.movie, date: selectedDate.wholeDate, time: selectedHour, screen: 10, row: seat.row, seat: seat.number, price: 12.99))
        }
        
        return tickets
    }
    
    func getTotal() -> Double {
        return 12.95
    }
}
