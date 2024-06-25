//
//  ImageLoader.swift
//  PlatziStore
//
//  Created by Andrea Murru on 24/06/2024.
//

import SwiftUI

struct CachedAsyncImage: View {
    @StateObject private var loader: ImageLoader

    init(url: URL) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipped()

        } else {
            ProgressView()
                .frame(height: 300)
                .onAppear {
                    loader.load()
                }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL

    init(url: URL) {
        self.url = url
    }

    func load() {
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let uiImage = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self?.image = UIImage(named: "EmptyImage")
                }
                return
            }

            ImageCacheManager.shared.setImage(uiImage, forKey: self.url.absoluteString)
            DispatchQueue.main.async {
                self.image = uiImage
            }
        }.resume()
    }
}
