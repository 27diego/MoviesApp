//
//  PeopleViwes.swift
//  TMDB
//
//  Created by Developer on 1/3/21.
//

import SwiftUI
import CoreData

struct CirclePeopleSectionView<T: NSManagedObject>: View where T: PersonCDProtocol {
    var people: Set<T>
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Spacer()
                    .frame(width: 10)
                ForEach(Array(people).prefix(<#T##maxLength: Int##Int#>), id: \.identifier) { person in
                    if person.profilePath != nil {
//                        NavigationLink(
//                            destination: NavigationLazyView(PersonDetailsView(person: PersonDetailsVM(for: person.id))),
//                            label: {
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
//                            })
                    }
                }
                Spacer()
                    .frame(width: 10)
            }
        }
    }
}
