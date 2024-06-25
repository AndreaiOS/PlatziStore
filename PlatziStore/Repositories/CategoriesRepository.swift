//
//  CategoriesRepository.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

protocol CategoriesRepository {
    func getCategories() async throws -> [Category]
}
