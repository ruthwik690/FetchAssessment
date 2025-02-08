//
//  Session.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import Foundation

/// A protocol-based Networking abstraction, which essentially just requires us to
/// duplicate the signature of the `URLSession.data` method within that protocol,
/// and to then make `URLSession` conform to our new protocol through an extension.
public protocol Session {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

public extension Session {
    /// If we want to avoid having to always pass `delegate: nil` at call sites where
    /// we're not interested in using a delegate, we also have to add the following
    /// convenience API (which `URLSession` itself provides when using it directly).
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

extension URLSession: Session {}
