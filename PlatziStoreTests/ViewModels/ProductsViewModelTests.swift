//
//  ProductsViewModelTests.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 21/06/2024.
//

import XCTest
@testable import PlatziStore

final class ProductsViewModelTests: XCTestCase {
    @MainActor func testFetchProducts() async {
        let fetchProductsUseCase = DefaultFetchProductsUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchSingleProductUseCase = DefaultFetchSingleProductUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchCategoriesUseCase = DefaultFetchCategoriesUseCase(repository: MockCategoriesRepository(dataSource: MockRemoteDataSource()))
        let viewModel = ProductsViewModel(fetchProductsUseCase: fetchProductsUseCase, fetchSingleProductUseCase: fetchSingleProductUseCase, fetchCategoriesUseCase: fetchCategoriesUseCase)
        
        await viewModel.fetchProducts(reset: true)
        
        XCTAssertEqual(viewModel.products.count, MockData.products.count) // MockData.products.count
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor func testFetchProduct() async {
        let fetchProductsUseCase = DefaultFetchProductsUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchSingleProductUseCase = DefaultFetchSingleProductUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchCategoriesUseCase = DefaultFetchCategoriesUseCase(repository: MockCategoriesRepository(dataSource: MockRemoteDataSource()))
        let viewModel = ProductsViewModel(fetchProductsUseCase: fetchProductsUseCase, fetchSingleProductUseCase: fetchSingleProductUseCase, fetchCategoriesUseCase: fetchCategoriesUseCase)
        
        await viewModel.fetchProduct(id: 1)
        
        XCTAssertEqual(viewModel.selectedProduct?.id, MockData.product.id)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor func testLoadMoreProducts() async {
        let fetchProductsUseCase = DefaultFetchProductsUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchSingleProductUseCase = DefaultFetchSingleProductUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchCategoriesUseCase = DefaultFetchCategoriesUseCase(repository: MockCategoriesRepository(dataSource: MockRemoteDataSource()))
        let viewModel = ProductsViewModel(fetchProductsUseCase: fetchProductsUseCase, fetchSingleProductUseCase: fetchSingleProductUseCase, fetchCategoriesUseCase: fetchCategoriesUseCase)
        
        await viewModel.fetchProducts(reset: true)
        XCTAssertEqual(viewModel.products.count, MockData.products.count) // First page with limit 10 (MockData.products.count)
        
        await viewModel.fetchProducts()
        XCTAssertEqual(viewModel.products.count, MockData.products.count) // Second page with limit 10 (no more products)
    }
    
    @MainActor func testFetchCategories() async {
        let fetchProductsUseCase = DefaultFetchProductsUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchSingleProductUseCase = DefaultFetchSingleProductUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchCategoriesUseCase = DefaultFetchCategoriesUseCase(repository: MockCategoriesRepository(dataSource: MockRemoteDataSource()))
        let viewModel = ProductsViewModel(fetchProductsUseCase: fetchProductsUseCase, fetchSingleProductUseCase: fetchSingleProductUseCase, fetchCategoriesUseCase: fetchCategoriesUseCase)
        
        await viewModel.fetchCategories()
        XCTAssertEqual(viewModel.categories.count, MockData.categories.count)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor func testFetchProductsByCategory() async {
        let fetchProductsUseCase = DefaultFetchProductsUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchSingleProductUseCase = DefaultFetchSingleProductUseCase(repository: MockProductsRepository(dataSource: MockRemoteDataSource()))
        let fetchCategoriesUseCase = DefaultFetchCategoriesUseCase(repository: MockCategoriesRepository(dataSource: MockRemoteDataSource()))
        let viewModel = ProductsViewModel(fetchProductsUseCase: fetchProductsUseCase, fetchSingleProductUseCase: fetchSingleProductUseCase, fetchCategoriesUseCase: fetchCategoriesUseCase)
        
        viewModel.currentCategoryID = 1
        
        await viewModel.fetchProducts(reset: true)
        XCTAssertEqual(viewModel.products.count, 1) // Assuming one product in category 1
        XCTAssertNil(viewModel.errorMessage)
    }
}
