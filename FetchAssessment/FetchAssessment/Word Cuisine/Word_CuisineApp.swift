//
//  Word_CuisineApp.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import SwiftUI

@main
struct Word_CuisineApp: App {
    
    @State private var showLaunchView: Bool = true

    var body: some Scene {
        WindowGroup {
            

                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    } else {
                        TabViewBar()
                    }
                }
                .zIndex(2.0)

                
        }
    }
}
