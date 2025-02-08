//
//  MockSession.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 02/02/25.
//

import Word_Cuisine
import Foundation

final class MockSession: Session {
    private let data: Data
    private let response: URLResponse
    private let error: Error?
    
    init(
        data: Data = .init(),
        response: URLResponse = .init(),
        error: Error? = nil
    ) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func data(
        for request: URLRequest,
        delegate: (any URLSessionTaskDelegate)?
    ) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        return (data, response)
    }
}

struct MockError: Error {}
