//
//  RemoteImage.swift
//  LaCasaDelSazon
//
//  Created by Developer on 11/25/20.
//

import SwiftUI
import Foundation
import Combine

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        @Published var data = Data()
        var state = LoadState.loading
        var imageStore = ImageCacheService.shared
        
        init(url: String){
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }
            
            if let result = imageStore.getImage(for: url) {
                DispatchQueue.main.async {
                    self.data = result
                    self.state = .success
                }
            }
            else {
                URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                    if let data = data, data.count > 0 {
                        DispatchQueue.main.async {
                            self.data = data
                            self.state = .success
                        }
                        self.imageStore.insert(data: data, for: url)
                    }
                    else {
                        self.state = .failure
                    }
                    
                    
                }.resume()
            }
        }
    }
    
    
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    
    var body: some View{
        selectImage()
            .renderingMode(.original)
            .resizable()
    }
    
    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName:"multiply.circle")){
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
            
        default:
            if let image = UIImage(data: loader.data){
                return Image(uiImage: image)
            }
            else {
                return failure
            }
        }
    }
}
