//
//  SearchView.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var search: SearchVM
    @State var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // MARK: - Fix boucing!!!!
                ZStack {
                    CustomSearch(isEditing: $isEditing, placeholder: search.placeholder, searchQuery: $search.searchQuery)
                }
                
                Picker(selection: $search.queryType, label: Text("Picker")){
                    Text("Movies").tag(searchType.movie)
                    Text("Actors").tag(searchType.actor)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                    .frame(height: 20)
                
                Text(search.queryType.description)
                    .foregroundColor(Color(.systemGray))
                Divider()
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 15) {
                        if search.queryType == .movie {
                            ForEach(search.movieResults) { movie in
                                NavigationLink(
                                    destination: NavigationLazyView(MovieDetailsView(movieDetails: MovieDetailsVM(for: movie.id))),
                                    label: {
                                        HStack {
                                            Text(movie.title)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                        }
                                    })
                            }
                        }
                        else {
                            ForEach(search.personResults) { person in
                                NavigationLink(
                                    destination: PersonDetailsView(person: PersonDetailsVM(for: person.id))){
                                        HStack {
                                            Text(person.name)
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                        }
                                    }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .animation(.none)
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color.white)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(search: SearchVM())
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
                        withAnimation(.spring()) {
                            isEditing = true
                        }
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
            .zIndex(3)
            
            if isEditing {
                Button(action: {
                    withAnimation(.spring()) {
                        isEditing = false
                        searchQuery = ""
                    }
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemGray))
                })
            }
        }
    }
}
