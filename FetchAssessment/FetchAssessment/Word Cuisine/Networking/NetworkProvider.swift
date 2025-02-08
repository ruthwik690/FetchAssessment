//
//  NetworkProvider.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 01/02/25.
//

import Foundation

public final class NetworkProvider: Network {
    
    public static let shared = NetworkProvider()
    
    public let session: Session
    public let decoder: JSONDecoder
    public let baseURL: URL?
    
    public init(
        session: Session = URLSession.shared,
        decoder: JSONDecoder = .init(),
        baseURL: URL? = NetworkURL.base
    ) {
        self.session = session
        self.decoder = decoder
        self.baseURL = baseURL
    }
    
    /// Executes an HTTP GET request to fetch meals for the provided category.
    public func fetchMeals(path: String) async throws -> [Recipe] {
        let url = try buildURL(
            for: path,
            relativeTo: baseURL,
            queryItems: []
        )
        print("API Call",url)
        let result: RecipeItemWrapper = try await fetch(
            from: url,
            headers: ["Accept": "application/json"]
        )
        return result.recipes
    }
}
