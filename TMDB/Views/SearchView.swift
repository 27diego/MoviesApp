//
//  SearchView.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var search = SearchVM()
    @State var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                CustomSearch(isEditing: $isEditing, placeholder: search.placeholder, searchQuery: $search.searchQuery)
                
                Picker(selection: .constant(1), label: Text("Picker")){
                    Text("Movies").tag(1)
                    Text("Actors").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                    .frame(height: 20)
                
                Text("Movies")
                    .foregroundColor(Color(.systemGray))
                Divider()
                ScrollView{
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(search.movieResults) { movie in
                           NavigationLink(
                            destination: NavigationLazyView(MovieDetailsView(for: movie.id)),
                            label: {
                                HStack {
                                    Text(movie.title)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                            })
                        }
                        .animation(.none)
                    }
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(12)
                
            }
            .padding(.horizontal)
            .animation(.spring())
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct CustomSearch: View {
    @Binding var isEditing: Bool
    var placeholder: String
    @Binding var searchQuery: String
    var body: some View {
        
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(isEditing ? placeholder : "Search", text: $searchQuery)
                    .onTapGesture {
                        isEditing = true
                    }
                if searchQuery != "" {
                    Image(systemName: "xmark.circle")
                        .onTapGesture {
                            searchQuery = ""
                        }
                }
            }
            .foregroundColor(Color(.systemGray))
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .zIndex(2)
            
            if isEditing {
                Button(action: {
                    isEditing = false
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemGray))
                })
            }
        }
    }
}
