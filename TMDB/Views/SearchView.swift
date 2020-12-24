//
//  SearchView.swift
//  TMDB
//
//  Created by Developer on 12/23/20.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var search = SearchVM()
    
    var body: some View {
        VStack {
            CustomSearch(text: $search.searchQuery, placeholders: search.searchPlaceholders)
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct CustomSearch: View {
    @State var editingTextField: Bool = false {
        didSet {
            if editingTextField == false {
                UIApplication.shared.endEditing()
            }
        }
    }
    @State var placeHolder: String = "Search"
    @Binding var text: String
    let timer = Timer.publish(every: 5, tolerance: 2.5, on: .main, in: .common)
        .autoconnect()
    
    var placeholders: [String]
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(placeHolder, text: $text){ change in
                        withAnimation(.spring()) {
                            editingTextField = change
                        }
                    }
                    .onReceive(timer, perform: { _ in
                        placeHolder = placeholders.randomElement() ?? "Search"
                    })
                }
                .foregroundColor(Color(.systemGray2))
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .zIndex(1)
                
                if editingTextField {
                    Button(action: {
                        withAnimation(.linear){
                            editingTextField.toggle()
                        }
                    }, label: {
                        Text("Cancel")
                    })
                    .foregroundColor(Color(.systemGray))
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            Text("Hello")
                .foregroundColor(.white)
        }
        .background(editingTextField ? Color.black : Color.clear)
        .cornerRadius(12)
    }
}
