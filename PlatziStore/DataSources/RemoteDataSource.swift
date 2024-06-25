//
//  RemoteDataSource.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

protocol RemoteDataSource {
    func fetchProducts(queryItems: [URLQueryItem]?) async throws -> [Product]
    func fetchProduct(id: Int) async throws -> Product
    func fetchCategories() async throws -> [Category]
}
