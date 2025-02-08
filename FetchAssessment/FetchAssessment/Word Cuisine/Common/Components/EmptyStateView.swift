//
//  EmptyStateView.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 05/02/25.
//

import SwiftUI

struct EmptyStateView: View {
    var message: String = "No recipes found. Try after some time!"

    var body: some View {
        VStack {
            Image(systemName: "tray")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray.opacity(0.6))
            
            Text(message)
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}
