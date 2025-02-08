//
//  ErrorView.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 1/31/25.
//

import SwiftUI

struct ErrorView: View {
    let errorTitle: String
    let errorMessage: String
    let retryAction: () async -> Void
    
    @State private var isVisible = false
    
    var body: some View {
        VStack(spacing: 16) {
            errorIcon
            errorText
            retryButton
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(.systemBackground)).shadow(radius: 10))
        .padding(.horizontal, 30)
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                isVisible = true
            }
        }
    }
}

// MARK: - Subviews
private extension ErrorView {
    var errorIcon: some View {
        Image(systemName: "x.circle.fill")
            .font(.system(size: 70))
            .foregroundColor(.red)
            .opacity(isVisible ? 1 : 0.5)
            .scaleEffect(isVisible ? 1 : 0.8)
            .animation(.spring(), value: isVisible)
    }
    
    var errorText: some View {
        VStack(spacing: 6) {
            Text(errorTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .opacity(isVisible ? 1 : 0)
            
            Text(errorMessage)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .opacity(isVisible ? 1 : 0)
        }
    }
    
    var retryButton: some View {
        Button(action: {
            Task {
                withAnimation {
                    isVisible = false
                }
                try? await Task.sleep(nanoseconds: 300_000_000) // Small delay
                await retryAction()
                withAnimation {
                    isVisible = true
                }
            }
        }) {
            Label("Try Again", systemImage: "arrow.clockwise")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
        .padding(.top, 10)
        .buttonStyle(.borderless)
        .opacity(isVisible ? 1 : 0)
    }
}

// MARK: - Preview
#Preview {
    ErrorView(
        errorTitle: "Something Went Wrong",
        errorMessage: "We couldn't complete your request. Please check your connection and try again.",
        retryAction: {}
    )
    .preferredColorScheme(.dark)
}
