//
//  CusineInfoViewModel.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import Combine
import Foundation
import SwiftUI

public extension CusineListView {
    
    final class ViewModel:  ObservableObject {
        
        /// Initializes the view model with provided Network object
        public init(network: Network = NetworkProvider.shared) {
            self.network = network
        }
        
        private let network: Network
        public var result: [Recipe] = []
        
        @Published public var recipes: [Recipe] = []
        @Published var linkString: String? = nil
        @Published var recipe: Recipe? = nil
        @Published var active: Bool = false
        @Published public var state: ViewState<[Recipe]> = .loading
        @Published public var searchText: String = ""
        
        
        @MainActor
        public func fetchRecipes(path: String = APIEndpoint.getRecipes.rawValue) async {
            do {
                result = try await network.fetchMeals(path: path).cleaned()
                self.state = .success(result: result)
                self.recipes = result
            } catch is NetworkError {
                state = .failure(message: "Please try again after some time")
            } catch let error as DecodingError {
                state = .failure(message: error.localizedDescription)
            } catch {
                state = .failure(message: error.localizedDescription)
            }
        }
        
        /// Sorts list of meals based on the current value of the `sortOrder`
        @MainActor
        public func sortBy(key: MealSortKey, order: MealSortOrder) {
            switch key {
            case .id:
                recipes = result.sorted(by: \.id, order: order)
            case .name:
                recipes = result.sorted(by: \.name, order: order)
            }
        }
        
        /// Filters list of meals based on the current value of the `searchText`
        @MainActor
        public func filter() {
            recipes = result.filtered(by: searchText)
        }
    }
}

public extension Array where Element == Recipe {
    /// Remove meals with missing data
    func cleaned() -> [Element] {
        self.lazy.filter { item in
            !item.uuid.isEmpty && !item.name.isEmpty
        }
    }
    /// Sort meals using the given key path and sort order
    func sorted<Key>(
        by keyPath: KeyPath<Element, Key>,
        order: MealSortOrder
    ) -> [Element] where Key: Comparable {
        switch order {
        case .ascending:
            self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
        case .descending:
            self.sorted { $0[keyPath: keyPath] > $1[keyPath: keyPath] }
        }
    }
    
    /// Filter meals by name based on the input query
    func filtered(by query: String) -> [Element] {
        query.isEmpty ? self : self.lazy.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
}
