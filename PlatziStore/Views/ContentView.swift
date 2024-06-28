//
//  ContentView.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch
    
    @ObservedObject var viewModel: ProductsViewModel
    
    @State private var categoriesLoaded = false
    @State private var productsLoaded = false
    @State private var showFilters = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.products.isEmpty {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorMessageView(errorMessage: errorMessage)
                } else if viewModel.products.isEmpty {
                    NoProductsView(isSearching: isSearching, productsLoaded: productsLoaded, onTryAgain: fetchProducts)
                } else {
                    ProductsGridView(viewModel: viewModel, columns: columns)
                }
            }
            .navigationTitle("Products")
            .toolbar {
                Button("Filters") {
                    showFilters = true
                }
            }
        }
        .onAppear(perform: loadProducts)
        .sheet(isPresented: $showFilters, onDismiss: fetchProducts, content: {
            FiltersView(showFilters: $showFilters, viewModel: viewModel, categoriesLoaded: $categoriesLoaded)
        })
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func loadProducts() {
        if !productsLoaded {
            Task {
                await viewModel.fetchProducts(reset: true)
                productsLoaded = true
            }
        }
    }
    
    private func fetchProducts() {
        Task {
            await viewModel.fetchProducts(reset: true)
        }
    }
}
