//
//  MockData.swift
//  PlatziStoreTests
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation
@testable import PlatziStore

struct MockData {
    static let products: [Product] = [
        Product(id: 1, title: "Mock Product 1", price: 100, description: "Description 1", category: Category(id: 1, name: "Category 1", image: ""), images: [""]),
        Product(id: 2, title: "Mock Product 2", price: 200, description: "Description 2", category: Category(id: 2, name: "Category 2", image: ""), images: [""])
    ]
    
    static let product = Product(id: 1, title: "Mock Product 1", price: 100, description: "Description 1", category: Category(id: 1, name: "Category 1", image: ""), images: [""])
    
    static let categories: [PlatziStore.Category] = [
        Category(id: 1, name: "Category 1", image: ""),
        Category(id: 2, name: "Category 2", image: "")
    ]
}
