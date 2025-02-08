//
//  CusineListView.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import SwiftUI

public struct CusineListView: View {
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var router: NavigationRouter
    
    var apiEndpoint: APIEndpoint
    public init(_ viewModel: ViewModel = .init(), apiEndpoint: APIEndpoint = .getRecipes) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.apiEndpoint = apiEndpoint
    }
    public var body: some View {
        ZStack {
            switch (viewModel.state) {
            case .loading:
                progress
                    .zIndex(1)
            case .success(let received):
                if received.isEmpty {
                    EmptyStateView()
                        .zIndex(2)
                } else {
                    content
                        .zIndex(2)
                }
            case .failure(let message):
                error(with: message)
                    .zIndex(2)
            }
        }
        .refreshable {
            await viewModel.fetchRecipes(path: apiEndpoint.rawValue)
        }
        .navigationTitle("Recipes")
    }
}


extension CusineListView {
    
    private var progress: some View {
        ProgressView("Fetching Data...")
            .task {
//                These lines of code are commented for testing purpose
//                if apiEndpoint == .getRecipes {
//                    viewModel.state = .loading
//                    try? await Task.sleep(for: .seconds(2))
//                    do {
//                        self.viewModel.recipes = try RecipeItemWrapper.sampleMalformed().recipes
//                        viewModel.state = .success(result: self.viewModel.recipes)
//                    } catch {
//                        viewModel.state = .failure(message: error.localizedDescription)
//                    }
//                } else {
                    viewModel.state = .loading
                    try? await Task.sleep(for: .seconds(1))
                    await viewModel.fetchRecipes(path: apiEndpoint.rawValue)
//                }
            }
    }
    
    private var content: some View {
        List {
            ForEach(viewModel.recipes) { recipe in
                Button {
                    router.navigate(to: .detail(obj: recipe))
                } label: {
                    FoodInfoCell(FoodInfoCell.ViewModel(recipe: recipe, infoTap: { url in
                        router.navigate(to: .gotoWeb(url: url))
                    }))
                }
            }
        }
        .searchable(
            text: $viewModel.searchText,
            prompt: "What are you craving for?"
        )
        .onChange(of: viewModel.searchText) {
            viewModel.filter()
        }
    }
    
    private func error(with message: String) -> some View {
        ErrorView(
            errorTitle: "Couldn't fetch",
            errorMessage: message
        ) {
            await viewModel.fetchRecipes(path: apiEndpoint.rawValue)
        }
    }
}
