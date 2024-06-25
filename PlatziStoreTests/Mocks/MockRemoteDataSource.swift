//
//  MockRemoteDataSource.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation
@testable import PlatziStore

final class MockRemoteDataSource: RemoteDataSource {
    func fetchProducts(queryItems: [URLQueryItem]?) async throws -> [Product] {
        let offset = queryItems?.first(where: { $0.name == "offset" })?.value ?? "0"
        let limit = queryItems?.first(where: { $0.name == "limit" })?.value ?? "10"
        let categoryId = queryItems?.first(where: { $0.name == "categoryId" })?.value

        let offsetInt = Int(offset) ?? 0
        let limitInt = Int(limit) ?? 10

        var filteredProducts = MockData.products
        if let categoryId = categoryId, let categoryInt = Int(categoryId) {
            filteredProducts = filteredProducts.filter { $0.category.id == categoryInt }
        }

        guard offsetInt < filteredProducts.count else {
            return []
        }

        let upperBound = min(offsetInt + limitInt, filteredProducts.count)
        let paginatedProducts = Array(filteredProducts[offsetInt..<upperBound])
        return paginatedProducts
    }

    func fetchProduct(id: Int) async throws -> Product {
        return MockData.product
    }

    func fetchCategories() async throws -> [PlatziStore.Category] {
        return MockData.categories
    }

    func fetchProductsByCategory(categoryId: Int) async throws -> [Product] {
        let filteredProducts = MockData.products.filter { $0.category.id == categoryId }
        return filteredProducts
    }
    
    func fetchProductsByName(title: String) async throws -> [PlatziStore.Product] {
        let filteredProducts = MockData.products.filter { $0.category.name == title }
        return filteredProducts
    }
}

