//
//  RecipeDetailsInfoView.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 01/02/25.
//

import SwiftUI

struct RecipeDetailsInfoView: View {
    
    @StateObject var viewModel: FoodInfoCell.ViewModel
    var body: some View {
        recipeInfo
    }
}


extension RecipeDetailsInfoView {
    private var recipeInfo: some View {
        
        List {
            Section {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: ContentMode.fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .clipped()
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 150)
                }
                Text(viewModel.recipe.cuisine)
                    .font(.subheadline)
            }
            Section("Links") {
                if viewModel.recipe.sourceURL != nil {
                    Button {
                        if let url = viewModel.recipe.sourceURL?.url {
                            viewModel.infoTap(url)
                        }
                    } label: {
                        Label("Recipe", systemImage: "magazine.fill")
                            .foregroundStyle(.green)
                            .colorMultiply(.white)
                    }
                }
                if viewModel.recipe.youtubeURL != nil {
                    Button {
                        if let url = viewModel.recipe.youtubeURL?.url {
                            viewModel.infoTap(url)
                        }
                    } label: {
                        Label("YouTube", systemImage: "video.fill")
                            .foregroundStyle(.red)
                            .colorMultiply(.white)
                    }
                }
            }
        }
        .navigationTitle(viewModel.recipe.name)
        
        .task {
            if let url = viewModel.recipe.photoURLLarge?.url {
                await viewModel.fetchImage(url: url)
            }
        }
    }
}
