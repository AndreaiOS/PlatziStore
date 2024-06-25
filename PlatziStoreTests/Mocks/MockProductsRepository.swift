//
//  MockProductsRepository.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation
@testable import PlatziStore

final class MockProductsRepository: ProductsRepository {
    private let dataSource: RemoteDataSource

    init(dataSource: RemoteDataSource) {
        self.dataSource = dataSource
    }

    func getProducts(queryItems: [URLQueryItem]?) async throws -> [Product] {
        return try await dataSource.fetchProducts(queryItems: queryItems)
    }

    func getProduct(id: Int) async throws -> Product {
        return try await dataSource.fetchProduct(id: id)
    }
    
    func getProductsByName(title: String) async throws -> [PlatziStore.Product] {
        return try await dataSource.fetchProducts(queryItems: [URLQueryItem(name: "title", value: "\(title)")])
    }
}

final class MockCategoriesRepository: CategoriesRepository {
    private let dataSource: RemoteDataSource

    init(dataSource: RemoteDataSource) {
        self.dataSource = dataSource
    }

    func getCategories() async throws -> [PlatziStore.Category] {
        return try await dataSource.fetchCategories()
    }
    
    func getProductsByCategory(categoryId: Int) async throws -> [PlatziStore.Product] {

        return try await dataSource.fetchProducts(queryItems: [URLQueryItem(name: "categoryId", value: "\(categoryId)")])
    }
}
