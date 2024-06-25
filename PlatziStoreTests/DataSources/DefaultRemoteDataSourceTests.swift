//
//  DefaultRemoteDataSourceTests.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 24/06/2024.
//

import XCTest
@testable import PlatziStore

final class DefaultRemoteDataSourceTests: XCTestCase {
    func testFetchProductsReturnsPaginatedProducts() async {
        let dataSource = MockRemoteDataSource()

        let queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "1")
        ]

        do {
            let products = try await dataSource.fetchProducts(queryItems: queryItems)
            XCTAssertEqual(products.count, 1)
            XCTAssertEqual(products.first?.id, MockData.products.first?.id)
        } catch {
            XCTFail("Expected to fetch products, but failed with error: \(error)")
        }
    }

    func testFetchProductsReturnsNextPageProducts() async {
        let dataSource = MockRemoteDataSource()

        let queryItems = [
            URLQueryItem(name: "offset", value: "1"),
            URLQueryItem(name: "limit", value: "1")
        ]

        do {
            let products = try await dataSource.fetchProducts(queryItems: queryItems)
            XCTAssertEqual(products.count, 1)
            XCTAssertEqual(products.first?.id, MockData.products[1].id)
        } catch {
            XCTFail("Expected to fetch products, but failed with error: \(error)")
        }
    }

    func testFetchProductsWithOffsetOutOfBounds() async {
        let dataSource = MockRemoteDataSource()

        let queryItems = [
            URLQueryItem(name: "offset", value: "100"),
            URLQueryItem(name: "limit", value: "10")
        ]

        do {
            let products = try await dataSource.fetchProducts(queryItems: queryItems)
            XCTAssertEqual(products.count, 0)
        } catch {
            XCTFail("Expected to fetch products, but failed with error: \(error)")
        }
    }
}
