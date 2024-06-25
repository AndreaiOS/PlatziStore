//
//  FetchSingleProductUseCase.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

protocol FetchSingleProductUseCase {
    func execute(id: Int) async throws -> Product
}
