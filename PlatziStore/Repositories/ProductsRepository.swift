//
//  ProductsRepository.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

protocol ProductsRepository {
    func getProducts(queryItems: [URLQueryItem]?) async throws -> [Product]
    func getProduct(id: Int) async throws -> Product
}
