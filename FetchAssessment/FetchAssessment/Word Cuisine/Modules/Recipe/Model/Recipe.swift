//
//  Recipe.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 30/01/25.
//

import Foundation

/// MARK: - Recipes
public struct Recipes: Codable {
    let recipes: [Recipe]
}
// MARK: - Recipe
public struct Recipe: Codable, Identifiable, Equatable, Hashable {
    public let uuid: String
    public let cuisine, name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid
        case youtubeURL = "youtube_url"
    }
    
    public init (uuid: String = UUID().uuidString,
                 cuisine: String = "",
                 name: String = "",
                 photoURLLarge: String? = nil,
                 photoURLSmall: String? = nil,
                 sourceURL: String? = nil,
                 youtubeURL: String? = nil) {
        self.uuid = uuid
        self.cuisine = cuisine
        self.name = name
        self.photoURLLarge = photoURLLarge
        self.photoURLSmall = photoURLSmall
        self.sourceURL = sourceURL
        self.youtubeURL = youtubeURL
    }
    
//    public init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        self.uuid = try container
//            .decodeIfPresent(String.self, forKey: .uuid)?
//            .trimmingCharacters(in: .whitespacesAndNewlines) ?? UUID().uuidString
//        self.cuisine = try container
//            .decodeIfPresent(String.self, forKey: .cuisine)?
//            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//        self.name = try container
//            .decodeIfPresent(String.self, forKey: .name)?
//            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//        let photoURLLarge = try container
//            .decodeIfPresent(String.self, forKey: .photoURLLarge)?
//            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
//        self.photoURLLarge = URL(string: photoURLLarge)
//        let photoURLSmall = try container
//            .decodeIfPresent(String.self, forKey: .photoURLSmall)?
//            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
//        self.photoURLSmall = URL(string: photoURLSmall)
//        let source = try container.decodeIfPresent(String.self, forKey: .sourceURL)?
//            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
//        self.sourceURL = URL(string: source)
//        let youtube = try container.decodeIfPresent(String.self, forKey: .youtubeURL)?
//            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
//        self.youtubeURL = URL(string: youtube)
//    }
}
extension Recipe {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Recipe {
    public var id: String {
        self.uuid
    }
}
