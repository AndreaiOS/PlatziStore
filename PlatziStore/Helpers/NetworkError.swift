//
//  NetworkError.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}
