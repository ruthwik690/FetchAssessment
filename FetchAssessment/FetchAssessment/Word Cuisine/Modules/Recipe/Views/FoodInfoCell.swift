//
//  FoodInfoCell.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import SwiftUI
import Combine

public struct FoodInfoCell: View {
    
    @StateObject var viewModel: ViewModel
   
    public init(_ viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        HStack() {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 60, height: 60)
                    .cornerRadius(10)
                    .clipped()
            } else {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            VStack(alignment: HorizontalAlignment.leading, spacing: 4) {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(viewModel.recipe.name)
                                .padding(.all, 0)
                                .font(Font.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.all, 0)
                        HStack {
                            Text(viewModel.recipe.cuisine)
                                .padding(.all, 0)
                                .font(Font.headline)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding(.all, 0)
                    }
                    Image(systemName: "chevron.right")
                }
            }
        }
        .task {
            if let url = viewModel.recipe.photoURLSmall?.url {
                await viewModel.fetchImage(url: url)
            }
        }
    }
}
