//
//  FetchCategoriesUseCase.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

protocol FetchCategoriesUseCase {
    func execute() async throws -> [Category]
}
