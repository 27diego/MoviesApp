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
        ScrollView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(theater.getTickets()) { ticket in
                            TicketView(ticket: ticket)
                        }
                        .frame(width: UIScreen.screenWidth)
                    }
                }
                
                NavigationLink(
                    destination: NavigationLazyView(OrderPaymentView(orderPayment: OrderPaymentVM(for: theater.getTotal()))),
                    label: {
                        Text("Continue")
                    })
                    .buttonStyle(CustomButtonStyle(color: .blue))
                    .padding([.horizontal, .bottom])
            }
        }
        .navigationBarTitle(Text("Confirm Tickets for \(theater.movie.title)"), displayMode: .inline)
    }
    
}

struct TicketView: View {
    var ticket: TicketModel
    var body: some View {
        VStack(spacing: 0) {
            TopTicketView(ticket: ticket)
                .background(Color.white)
                .clipShape(TicketShape())
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y:10)
            
            DashedSeparator()
                .stroke(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [4,8], dashPhase: 4))
                .frame(height: 0.4)
                .padding(.horizontal)
            
            BottomTicketView()
                .background(Color.gray.opacity(0.4))
                .clipShape(TicketShape().rotation(Angle(degrees: 180)))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
            
        }
        .padding()
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
            
            RemoteImage(url: ImageEndpoint(path: ticket.movie.backdropPath ?? "").url)
                .frame(minWidth: 0.0, maxWidth: .infinity)
                .aspectRatio(contentMode: .fill)
            
            HStack {
                DetailsView(detail1: "Screen", detail2: "18", detail3: "Price", detail4: "$5.68")
                DetailsView(detail1: "Row", detail2: "\(ticket.row)", detail3: "Date", detail4: ticket.date)
                DetailsView(detail1: "Seat", detail2: "\(ticket.seat)", detail3: "Time", detail4: ticket.time)
            }
            .padding(.vertical)
        }
    }
}

struct BottomTicketView: View {
    var body: some View {
        Image("Barcode")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .padding(30)
            .frame(minWidth: 0.0, maxWidth: .infinity)
    }
}

struct DetailsView: View {
    var detail1 = "Seat"
    var detail2 = "34"
    var detail3 = "Time"
    var detail4 = "18:15"
    
    var body: some View {
        VStack(spacing: 10){
            VStack {
                Text(detail1)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.gray)
                Text(detail2)
                    .font(.system(size: 30, weight: .bold))
            }
            
            VStack {
                Text(detail3)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.gray)
                
                Text(detail4)
                    .font(.system(size: 15, weight: .bold))
            }
        }
        .frame(minWidth: 0.0, maxWidth: .infinity)
    }
}
