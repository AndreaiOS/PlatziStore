//
//  ProductsViewModel.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

@MainActor class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedProduct: Product?
    @Published var searchText: String = ""
    @Published var currentCategoryID: Int?
    @Published var priceMin: Double = 0
    @Published var priceMax: Double = 1000

    private let fetchProductsUseCase: FetchProductsUseCase
    private let fetchSingleProductUseCase: FetchSingleProductUseCase
    private let fetchCategoriesUseCase: FetchCategoriesUseCase

    private var offset = 0
    private let limit = 10
    private var canLoadMore = true
    
    init(fetchProductsUseCase: FetchProductsUseCase, 
         fetchSingleProductUseCase: FetchSingleProductUseCase,
         fetchCategoriesUseCase: FetchCategoriesUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
        self.fetchSingleProductUseCase = fetchSingleProductUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
    }

    func fetchProducts(reset: Bool = false) async {
        if isLoading { return }

        isLoading = true
        errorMessage = nil

        if reset {
            offset = 0
            products = []
            canLoadMore = true
        }

        do {
            var queryItems = [
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
            
            if !searchText.isEmpty {
                queryItems.append(URLQueryItem(name: "title", value: "\(searchText)"))
            }
            
            if let categoryId = currentCategoryID {
                queryItems.append(URLQueryItem(name: "categoryId", value: "\(categoryId)"))
            }
            
            if priceMin != 0 || priceMax != 1000 {
                queryItems.append(URLQueryItem(name: "price_min", value: "\(Int(priceMin))"))
                queryItems.append(URLQueryItem(name: "price_max", value: "\(Int(priceMax))"))
            }
            
            let fetchedProducts = try await fetchProductsUseCase.execute(queryItems: queryItems)
            if fetchedProducts.count < limit {
                canLoadMore = false
            }
            products.append(contentsOf: fetchedProducts)
            offset += limit
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func fetchProduct(id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            selectedProduct = try await fetchSingleProductUseCase.execute(id: id)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func loadMoreProductsIfNeeded(currentProduct product: Product?) async {
        guard let product = product, currentCategoryID == nil || currentCategoryID == 0 else {
            return
        }

        let thresholdIndex = products.index(products.endIndex, offsetBy: -1)
        if products.firstIndex(where: { $0.id == product.id }) == thresholdIndex && canLoadMore {
            await fetchProducts()
        }
    }

    func fetchCategories() async {
        isLoading = true
        errorMessage = nil
        do {
            categories = try await fetchCategoriesUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
