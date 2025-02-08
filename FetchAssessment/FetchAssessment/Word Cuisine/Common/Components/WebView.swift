//
//  WebView.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let string: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: string) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
