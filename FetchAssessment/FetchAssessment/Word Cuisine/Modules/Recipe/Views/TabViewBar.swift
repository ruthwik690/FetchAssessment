//
//  TabViewBar.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 05/02/25.
//

import SwiftUI

struct TabViewBar: View {
    @StateObject private var router = NavigationRouter()
    
    var body: some View {
        TabView {
            NavigationStack(path: $router.path) {
                CusineListView(apiEndpoint: APIEndpoint.getRecipes)
                    .navigationDestination(
                        for: NavigationRouter.Destination.self,
                        destination: router.view(for:)
                    )
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("All")
            }
            .environmentObject(router)
            NavigationStack(path: $router.path) {
                CusineListView(apiEndpoint: APIEndpoint.getMalformedRecipes)
                    .navigationDestination(
                        for: NavigationRouter.Destination.self,
                        destination: router.view(for:)
                    )
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Malformed")
            }
            .environmentObject(router)
            NavigationStack(path: $router.path) {
                CusineListView(apiEndpoint: APIEndpoint.getEmpty)
                    .navigationDestination(
                        for: NavigationRouter.Destination.self,
                        destination: router.view(for:)
                    )
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Empty")
            }
            .environmentObject(router)
        }
    }
}

