//
//  FetchProductsUseCase.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

protocol FetchProductsUseCase {
    func execute(queryItems: [URLQueryItem]?) async throws -> [Product]
}
