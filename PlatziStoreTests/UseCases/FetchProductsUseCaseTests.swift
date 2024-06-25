//
//  FetchProductsUseCaseTests.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 21/06/2024.
//

import XCTest
@testable import PlatziStore

final class FetchProductsUseCaseTests: XCTestCase {
    func testExecuteReturnsPaginatedProducts() async {
        let repository = MockProductsRepository(dataSource: MockRemoteDataSource())
        let useCase = DefaultFetchProductsUseCase(repository: repository)

        let queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "1")
        ]

        do {
            let products = try await useCase.execute(queryItems: queryItems)
            XCTAssertEqual(products.count, 1) // Should return 1 product as per limit
            XCTAssertEqual(products.first?.id, MockData.products.first?.id)
        } catch {
            XCTFail("Expected to fetch products, but failed with error: \(error)")
        }
    }

    func testExecuteReturnsNextPageProducts() async {
        let repository = MockProductsRepository(dataSource: MockRemoteDataSource())
        let useCase = DefaultFetchProductsUseCase(repository: repository)

        let queryItems = [
            URLQueryItem(name: "offset", value: "1"),
            URLQueryItem(name: "limit", value: "1")
        ]

        do {
            let products = try await useCase.execute(queryItems: queryItems)
            XCTAssertEqual(products.count, 1) // Should return 1 product as per limit
            XCTAssertEqual(products.first?.id, MockData.products[1].id)
        } catch {
            XCTFail("Expected to fetch products, but failed with error: \(error)")
        }
    }
}
