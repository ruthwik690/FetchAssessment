//
//  NavigationRouter.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 03/02/25.
//
import SwiftUI

/// This model controls the the app's navigation stack
final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    @ViewBuilder func view(for destination: Destination) -> some View {
        switch destination {
        case .detail(obj: let recipe):
            RecipeDetailsInfoView(viewModel: FoodInfoCell.ViewModel(recipe: recipe, infoTap: { url in
                self.navigate(to: Destination.gotoWeb(url: url))
            }))
        case .gotoWeb(url: let url):
            WebView(string: url.absoluteString)
        }
    }
    
    enum Destination: Hashable {
        case detail(obj: Recipe)
        case gotoWeb(url: URL)
        
    }
    
    /// Convenience wrapper to restrict navigation to only `Destination` type,
    /// as the `NavigationPath` holds type-erased objects.
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    /// Safely pops the last element from the `NavigationPath`.
    func dismiss() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
