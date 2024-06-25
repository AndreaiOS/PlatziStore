//
//  FetchCategoriesUseCaseTests.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 21/06/2024.
//

import XCTest
@testable import PlatziStore

final class FetchCategoriesUseCaseTests: XCTestCase {
    func testExecuteReturnsCategories() async {
        let repository = MockCategoriesRepository(dataSource: MockRemoteDataSource())
        let useCase = DefaultFetchCategoriesUseCase(repository: repository)

        do {
            let categories = try await useCase.execute()
            XCTAssertEqual(categories.count, MockData.categories.count)
        } catch {
            XCTFail("Expected to fetch categories, but failed with error: \(error)")
        }
    }
}
