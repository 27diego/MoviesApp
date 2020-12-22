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
        var data = Data()
        var state = LoadState.loading

        init(url: String){
            guard let parsedURL = URL(string: url) else {
                print("This is the invalid URL!!!!: \(url) --------")
                fatalError("Invalid URL: \(url)")
            }

            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                }
                else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }


    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View{
        selectImage()
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



//
//class ImageLoader: ObservableObject {
//    @Published var image: UIImage?
//    private let url: URL
//    private var cancellable: AnyCancellable?
//
//    init(url: URL){
//        self.url = url
//    }
//
//    deinit {
//        cancel()
//    }
//
//    func load(){
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { UIImage(data: $0.data) }
//            .replaceError(with: nil)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] in self?.image = $0 }
//    }
//
//    func cancel(){
//        cancellable?.cancel()
//    }
//}
//
//struct RemoteImage: View {
//    @StateObject private var loader: ImageLoader
//
//    init(url: String){
//        let tempUrl = URL(string: url)!
//        _loader = StateObject(wrappedValue: ImageLoader(url: tempUrl))
//    }
//
//
//    var body: some View {
//        content
//            .onAppear(perform: loader.load)
//    }
//
//    private var content: some View {
//        Group {
//            if loader.image != nil {
//                Image(uiImage: loader.image!)
//                    .resizable()
//            } else {
//                Text("Loading....")
//            }
//        }
//    }
//}
