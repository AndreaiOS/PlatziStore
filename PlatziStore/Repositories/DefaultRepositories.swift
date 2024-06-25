//
//  DefaultRepositories.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//
//  Repositories abstract the data layer

import Foundation

final class DefaultProductsRepository: ProductsRepository {
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
}

final class DefaultCategoriesRepository: CategoriesRepository {
    private let dataSource: RemoteDataSource

    init(dataSource: RemoteDataSource) {
        self.dataSource = dataSource
    }

    func getCategories() async throws -> [Category] {
        return try await dataSource.fetchCategories()
    }
}
