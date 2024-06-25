//
//  Product.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//
//  Entities are the core data structures

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]
}
