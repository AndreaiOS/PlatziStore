//
//  ProductsGridView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 25/06/2024.
//

import SwiftUI

struct ProductsGridView: View {
    @ObservedObject var viewModel: ProductsViewModel
    let columns: [GridItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.products, id: \.id) { product in
                    NavigationLink(destination: ProductDetailView(productId: product.id, viewModel: viewModel)) {
                        ProductCellView(product: product)
                            .onAppear {
                                Task {
                                    await viewModel.loadMoreProductsIfNeeded(currentProduct: product)
                                }
                            }
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .padding()
        }
    }
}
