//
//  OrderView.swift
//  TMDB
//
//  Created by Developer on 12/31/20.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var theater: TheaterVM
    var body: some View {
        TicketShape()
            .frame(width: 200, height: 200)
    }
}

struct TicketView: View {
    var ticket: TicketModel
    var body: some View {
        Text("")
    }
}

struct TopTicketView: View {
    var ticket: TicketModel
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text(ticket.movie.releaseDate ?? "")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.gray)
                
                Text(ticket.movie.title)
                    .font(.system(size: 30, weight: .black))
            }
            .frame(minWidth: 0.0, maxWidth: .infinity, alignment: .leading)
            .padding(.top, 30)
            .padding(.horizontal)
        }
        
        RemoteImage(url: ImageEndpoint(path: ticket.movie.backdropPath ?? "").url)
            .frame(minWidth: 0.0, maxWidth: .infinity)
            .scaledToFit()
        
        HStack {
            
        }
        
    }
}

struct DetailsView: View {
    var detail1 = "Seat"
    var detail2 = "34"
    var detail3 = "Time"
    var detail4 = "18:15"
    
    var body: some View {
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(TheaterVM(for: MovieModel(id: 464052, title: "Wonder Woman 1984", popularity:  6707.014, releaseDate: "2020-12-16", backdropPath: "/srYya1ZlI97Au4jUYAktDe3avyA.jpg", posterPath:  "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.")))
    }
}
