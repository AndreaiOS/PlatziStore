//
//  DefaultRemoteDataSource.swift
//  PlatziStore
//
//  Created by Andrea Murru on 21/06/2024.
//
//  Data sources handle the actual network calls

import Foundation

final class DefaultRemoteDataSource: RemoteDataSource {
    private let baseURL = "https://api.escuelajs.co/api/v1/"

    func fetchCategories() async throws -> [Category] {
        guard let url = URL(string: baseURL + "categories") else { throw NetworkError.invalidURL }
        return try await fetchData(from: url, as: [Category].self)
    }

    func fetchProducts(queryItems: [URLQueryItem]?) async throws -> [Product] {
        var components = URLComponents(string: baseURL + "products")!
        components.queryItems = queryItems
        guard let url = components.url else { throw NetworkError.invalidURL }
        return try await fetchData(from: url, as: [Product].self)
    }

    func fetchProduct(id: Int) async throws -> Product {
        guard let url = URL(string: baseURL + "products/\(id)") else { throw NetworkError.invalidURL }
        return try await fetchData(from: url, as: Product.self)
    }
    
    private func fetchData<T: Decodable>(from url: URL, as type: T.Type) async throws -> T {
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw NetworkError.requestFailed(error)
        }

        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
