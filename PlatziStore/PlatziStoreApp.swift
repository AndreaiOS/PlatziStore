//
//  PlatziStoreApp.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

// This structure follows MVVM principles while adhering to CLEAN architecture.
// Each component has its own responsibility, making the codebase more maintainable, testable, and scalable.
// The ViewModel interacts with UseCases to fetch data and update the View.
// The UseCases interact with Repositories, which in turn interact with DataSources to fetch the data from the network.

// 1.    Entities: Core data models.
// 2.    Use Cases: Encapsulate business logic.
// 3.    Repositories: Abstract data access.
// 4.    Data Sources: Handle network calls.
// 5.    ViewModel: Manages the state and interacts with UseCases.
// 6.    Views: Display data and bind to the ViewModel.
// Each component has its own responsibility, making the codebase more maintainable, testable, and scalable.

import SwiftUI

@main
struct PlatziStoreApp: App {
    var body: some Scene {
        WindowGroup {
            let remoteDataSource = DefaultRemoteDataSource()
            let productsRepository = DefaultProductsRepository(dataSource: remoteDataSource)
            let categoriesRepository = DefaultCategoriesRepository(dataSource: remoteDataSource)
            let fetchProductsUseCase = DefaultFetchProductsUseCase(repository: productsRepository)
            let fetchSingleProductUseCase = DefaultFetchSingleProductUseCase(repository: productsRepository)
            let fetchCategoryUseCase = DefaultFetchCategoriesUseCase(repository: categoriesRepository)
            let productsViewModel = ProductsViewModel(fetchProductsUseCase: fetchProductsUseCase, fetchSingleProductUseCase: fetchSingleProductUseCase, fetchCategoriesUseCase: fetchCategoryUseCase)
            ContentView(viewModel: productsViewModel)
        }
    }
}
