//
//  FoodInfoCellViewModel.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import Foundation
import SwiftUI


public extension FoodInfoCell {
 
  final class ViewModel: ObservableObject {
        private var viewDataModel: FoodInfoCellViewDataModel = FoodInfoCellViewDataModel()
        
        @Published var image: UIImage?
        @Published var recipe: Recipe
        var infoTap: (URL) -> Void
        init(recipe: Recipe,
             infoTap: @escaping (URL) -> Void) {
            self.recipe = recipe
            self.infoTap = infoTap
        }
        
        func fetchImage(url: URL) async {
            if let image = await viewDataModel.getImage(for: url.absoluteString) {
                await MainActor.run {
                    self.image = image
                }
            }
        }
    }
}

