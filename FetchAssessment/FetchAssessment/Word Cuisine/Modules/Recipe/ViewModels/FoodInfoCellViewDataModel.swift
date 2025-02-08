//
//  FoodInfoCellViewDataModel.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//
import Foundation
import UIKit

class FoodInfoCellViewDataModel {

    func getImage(for urlString: String) async -> UIImage? {
        return try? await ImageCache.shared.fetchImage(from: urlString)
    }
}
