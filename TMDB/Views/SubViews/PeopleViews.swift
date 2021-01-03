//
//  PeopleViwes.swift
//  TMDB
//
//  Created by Developer on 1/3/21.
//

import SwiftUI

struct CirclePeopleSectionView<T: Person>: View {
    var people: [T]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Spacer()
                    .frame(width: 10)
                ForEach(people) { person in
                    if person.profilePath != nil {
                        NavigationLink(
                            destination: NavigationLazyView(PersonDetailsView(person: PersonDetailsVM(for: person.id))),
                            label: {
                                VStack {
                                    RemoteImage(url: ImageEndpoint(path: person.profilePath ?? "").url)
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                    
                                    Text(person.name)
                                        .frame(width: 100)
                                        .clipped()
                                    
                                }
                                .foregroundColor(.black)
                            })
                    }
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}
