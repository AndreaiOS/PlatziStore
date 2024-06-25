//
//  DefaultUseCases.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//
// Use cases encapsulate the business logic

import Foundation

final class DefaultFetchProductsUseCase: FetchProductsUseCase {
    private let repository: ProductsRepository

    init(repository: ProductsRepository) {
        self.repository = repository
    }

    func execute(queryItems: [URLQueryItem]?) async throws -> [Product] {
        return try await repository.getProducts(queryItems: queryItems)
    }
}

final class DefaultFetchSingleProductUseCase: FetchSingleProductUseCase {
    private let repository: ProductsRepository

    init(repository: ProductsRepository) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> Product {
        return try await repository.getProduct(id: id)
    }
}

final class DefaultFetchCategoriesUseCase: FetchCategoriesUseCase {
    private let repository: CategoriesRepository

    init(repository: CategoriesRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Category] {
        return try await repository.getCategories()
    }
}
