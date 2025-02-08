//
//  MockNetworkProvider.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 02/02/25.
//

import Word_Cuisine
import Foundation

final class MockNetworkProvider: Network {
   
    let session: any Session
    let decoder: JSONDecoder
    
    init(
        session: any Session,
        decoder: JSONDecoder = .init()
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    public func fetchMeals(path: String) async throws -> [Recipe] {
        let result: RecipeItemWrapper = try await fetch(
            from: NetworkURL.base,
            headers: ["Accept": "application/json"]
        )
        return result.recipes
    }
}
