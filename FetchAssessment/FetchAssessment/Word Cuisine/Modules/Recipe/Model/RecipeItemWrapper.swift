//
//  RecipeItemWrapper.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 05/02/25.
//

public struct RecipeItemWrapper: Codable, Equatable {
    public let recipes: [Recipe]

    enum CodingKeys: String, CodingKey {
        case recipes
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recipes = try container.decodeIfPresent([Recipe].self, forKey: .recipes) ?? []
    }
}
