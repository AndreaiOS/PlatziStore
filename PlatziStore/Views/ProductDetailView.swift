//
//  ProductDetailView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 24/06/2024.
//

import SwiftUI


struct ProductDetailView: View {
    let productId: Int
    @ObservedObject var viewModel: ProductsViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.selectedProduct == nil {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else if let product = viewModel.selectedProduct {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(product.title)
                            .font(.largeTitle)
                            .padding()
                        HStack {
                            Spacer()
                            Text(product.price.formatted(.number.precision(.fractionLength(2))) + "$")
                                .font(.headline)
                                .foregroundColor(Color.primary)
                        }
                        .padding()
                        Text(product.description)
                            .padding()
                        ForEach(product.images, id: \.self) { imageUrl in
                            if let url = URL(string: imageUrl) {
                                CachedAsyncImage(url: url)
                                    .frame(maxHeight: 200)
                                    .padding()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Product Detail")
        .onAppear {
            Task {
                await viewModel.fetchProduct(id: productId)
            }
        }
    }
}
