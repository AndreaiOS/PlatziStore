//
//  Category.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//
//  Entities are the core data structures

import Foundation

struct Category: Decodable {
    let id: Int
    let name: String
    let image: String
}
