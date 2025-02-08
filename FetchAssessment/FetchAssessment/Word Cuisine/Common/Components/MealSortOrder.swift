//
//  MealSortOrder.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 04/02/25.
//

import Foundation

/// List of available sorting keys
public enum MealSortKey: String, Identifiable, CaseIterable {
    public var id: Self { self }
    
    case id = "Id"
    case name = "Name"
}

/// List of different sort order
public enum MealSortOrder: String, Identifiable, CaseIterable {
    public var id: Self { self }
    
    case ascending = "Ascending"
    case descending = "Descending"
}

/// List of different sort order
public enum Endpoint: String, Identifiable, CaseIterable {
    public var id: Self { self }
    case none = "None"
    case allRecipes = "All Recipes"
    case malformedData = "Malformed Data"
    case emptyData = "Empty Data"
    
    public var endpoint: String {
        switch self {
        case .none:
            return ""
        case .allRecipes:
            return APIEndpoint.getRecipes.rawValue
        case .malformedData:
            return APIEndpoint.getMalformedRecipes.rawValue
        case .emptyData:
            return APIEndpoint.getEmpty.rawValue
        }
    }
}
