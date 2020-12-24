//
//  TheaterView.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import SwiftUI

struct TheaterView: View {
    @Binding var selectedSeats: [Seat]
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [.purple, .clear]), startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 0.5)))
                .frame(height: 420)
                .clipShape(ScreenShape(isClip: true))
                .cornerRadius(20)
            
            ScreenShape()
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .square))
                .frame(height: 420)
                .foregroundColor(Color.blue)
            
            VStack{
                createFrontRows()
                createBackRows()
                HStack{
                    ChairLegend(text: "Selected", color: .blue)
                    ChairLegend(text: "Reserved", color: .pink)
                    ChairLegend(text: "Available", color: .gray)
                }.padding(.horizontal, 20).padding(.top)
            }
            
        }
    }
    
    fileprivate func createFrontRows() -> some View {
        let rows: Int = 2
        let numbersPerRow: Int = 7
        
        return
            VStack {
                ForEach(0..<rows, id: \.self) { row in
                    HStack{
                        ForEach(0..<numbersPerRow, id: \.self){ number in
                            ChairView(width: 30, accentColor: .blue, seat: Seat(id: UUID(), row: row + 1, number: number + 1) , onSelect: { seat in
                                self.selectedSeats.append(seat)
                            }, onDeselect: { seat in
                                self.selectedSeats.removeAll(where: {$0.id == seat.id})
                            })
                        }
                    }
                }
            }
    }
    
    fileprivate func createBackRows() -> some View {
        let rows: Int = 5
        let numbersPerRow: Int = 9
        
        return
            VStack {
                ForEach(0..<rows, id: \.self) { row in
                    HStack{
                        ForEach(0..<numbersPerRow, id: \.self){ number in
                            ChairView(width: 30, accentColor: .blue, seat: Seat(id: UUID(), row: row + 3, number: number + 15) , onSelect: { seat in
                                self.selectedSeats.append(seat)
                            }, onDeselect: { seat in
                                self.selectedSeats.removeAll(where: {$0.number == seat.number})
                            })
                        }
                    }
                }
            }
    }
}

struct TheaterView_Previews: PreviewProvider {
    static var previews: some View {
        TheaterView(selectedSeats: .constant([]))
    }
}


struct ChairView: View {
    var width: CGFloat = 50
    var accentColor: Color
    var seat = Seat(id: UUID(), row: 1, number: 5)
    var isSelectable = true
    var onSelect: ((Seat)-> ()) = { _ in }
    var onDeselect: ((Seat)-> ()) = { _ in }
    
    @State var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 2){
            Rectangle()
                .frame(width: self.width, height: self.width * 2/3)
                .foregroundColor(isSelectable ? isSelected ? accentColor : Color.gray.opacity(0.5) : accentColor)
                .cornerRadius(width / 5)
            
            Rectangle()
                .frame(width: self.width - 10, height: self.width / 5)
                .foregroundColor(isSelectable ? isSelected ? accentColor : Color.gray.opacity(0.5) : accentColor)
                .cornerRadius(width / 5)
        }
        .onTapGesture {
            if self.isSelectable {
                self.isSelected.toggle()
                if self.isSelected {
                    self.onSelect(self.seat)
                }
                else {
                    self.onDeselect(self.seat)
                }
            }
        }
    }
}


struct ChairLegend: View {
    var text: String
    var color: Color
    
    var body: some View {
        HStack{
            ChairView(width: 20, accentColor: color, isSelectable: false)
            Text(text)
                .font(.subheadline)
                .foregroundColor(color)
        }.frame(maxWidth: .infinity)
    }
}
