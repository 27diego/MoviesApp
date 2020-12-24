//
//  SearchView.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 13) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                Text("Search Movies")
                    .font(.system(size: 17.5))
                Spacer()
            }
            .foregroundColor(Color(.systemGray2))
            .padding(.horizontal, 15)
            .zIndex(2)
            .frame(width: UIScreen.screenWidth*0.9)
            
            TextField("", text: .constant(""))
                .padding()
                .background(Color(.systemGray6))
                .frame(width: UIScreen.screenWidth*0.9)
                .cornerRadius(12)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
