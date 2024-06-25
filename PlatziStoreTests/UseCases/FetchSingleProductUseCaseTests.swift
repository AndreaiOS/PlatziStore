//
//  FetchSingleProductUseCaseTests.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 21/06/2024.
//

import XCTest
@testable import PlatziStore

final class FetchSingleProductUseCaseTests: XCTestCase {
    func testExecuteReturnsProduct() async {
        let repository = MockProductsRepository(dataSource: MockRemoteDataSource())
        let useCase = DefaultFetchSingleProductUseCase(repository: repository)

        do {
            let product = try await useCase.execute(id: 1)
            XCTAssertEqual(product.id, MockData.product.id)
        } catch {
            XCTFail("Expected to fetch a product, but failed with error: \(error)")
        }
    }
}
