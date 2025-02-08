//
//  LaunchView.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 2/7/25.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var loadingText: [String] = "Loading your Recipes...".map { String($0) }
    @State private var showLoadingText: Bool = false
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            Image("tinted_icon")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor( Color(UIColor(named: "launchColor") ?? UIColor.white))
            
            loadingTextView
                .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            handleTimerTick()
        }
    }
    
    // Extracted loading text view
    private var loadingTextView: some View {
        HStack(spacing: 0) {
            ForEach(loadingText.indices, id: \.self) { index in
                Text(loadingText[index])
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(.systemYellow))
                    .offset(y: counter == index ? -5 : 0)
            }
        }
        .opacity(showLoadingText ? 1 : 0)
    }
    
    // Extracted timer logic
    private func handleTimerTick() {
        withAnimation(.spring()) {
            let lastIndex = loadingText.count - 1
            if counter == lastIndex {
                counter = 0
                loops += 1
                if loops >= 2 {
                    showLaunchView = false
                }
            } else {
                counter += 1
            }
        }
    }
}
