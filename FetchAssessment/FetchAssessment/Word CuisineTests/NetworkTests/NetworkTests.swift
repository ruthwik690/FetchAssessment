//
//  NetworkTests.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 02/02/25.
//

@testable import Word_Cuisine
import XCTest

final class NetworkTests: XCTestCase {
    private var session: Session!
    private var network: Network!

    override func tearDownWithError() throws {
        session = nil
        network = nil
    }
    
    // Test building a URL successfully without query parameters
    func testBuildURL_Success() throws {
        session = MockSession()
        network = MockNetworkProvider(session: session)
        let expectedURL = "\(NetworkURL.base.absoluteString)/testResource"
        
        let actualURL = try network.buildURL(
            for: "/testResource",
            relativeTo: NetworkURL.base,
            queryItems: []
        )
        XCTAssertEqual(expectedURL, actualURL.absoluteString, "The built URL should match the expected URL.")
    }
    
    // Test building a URL successfully with query parameters
    func testBuildURL_Success_WithQueryParameters() throws {
        session = MockSession()
        network = MockNetworkProvider(session: session)
        let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")
        let expectedURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        let actualURL = try network.buildURL(
            for: "recipes.json",
            relativeTo: baseURL,
            queryItems: [URLQueryItem]()
        )
        
        XCTAssertEqual(expectedURL, actualURL.absoluteString, "The built URL with query parameters should match the expected URL.")
    }
    
    // Test handling a malformed URL error
    func testBuildURL_MalformedURL() throws {
        session = MockSession()
        network = MockNetworkProvider(session: session)
        
        do {
            let malformedURL = try network.buildURL(
                for: "malformed/url",
                relativeTo: nil,
                queryItems: []
            )
            print("Malformed URL: \(malformedURL.absoluteString)")
        } catch NetworkError.malformedURL {
            print("Caught expected malformed URL error.")
            return
        }
        XCTFail("The test should have caught a malformed URL error.")
    }

    // Test executing a network request successfully
    func testExecute_Success() async throws {
        let expectedRecipe = Recipe.sample
        session = MockSession(
            data: Recipe.sampleJSON,
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.ok,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        
        let request = URLRequest(url: NetworkURL.base)
        let (data, response) = try await network.execute(request: request)
        
        XCTAssertEqual(response.statusCode, Http.Status.ok, "The response status code should be 200 (OK).")
        
        let decodedRecipe = try JSONDecoder().decode(Recipe.self, from: data)
        XCTAssertEqual(decodedRecipe, expectedRecipe, "The decoded recipe should match the expected recipe.")
    }
    
    // Test handling a session error during network request execution
    func testExecute_SessionError() async throws {
        session = MockSession(error: MockError())
        network = MockNetworkProvider(session: session)
        
        do {
            let request = URLRequest(url: NetworkURL.base)
            _ = try await network.execute(request: request)
        } catch {
            print("Caught expected session error: \(error)")
            XCTAssertTrue(error is MockError)
            return
        }
        XCTFail("The test should have caught a session error.")
    }
    
    // Test handling an unknown URLResponse error
    func testExecute_UnknownError() async throws {
        session = MockSession()
        network = MockNetworkProvider(session: session)
        
        do {
            let request = URLRequest(url: NetworkURL.base)
            _ = try await network.execute(request: request)
        } catch NetworkError.unknown(let response) {
            print("Caught unknown error with response: \(response)")
            return
        }
        XCTFail("The test should have caught an unknown error.")
    }
    
    // Test handling an HTTP error response
    func testExecute_HttpError() async throws {
        let errorCode = Http.Status.errors.randomElement()!
        session = MockSession(response: HTTPURLResponse(
            url: NetworkURL.base,
            statusCode: errorCode,
            httpVersion: nil,
            headerFields: nil
        )!)
        network = MockNetworkProvider(session: session)
        
        do {
            let request = URLRequest(url: NetworkURL.base)
            _ = try await network.execute(request: request)
        } catch NetworkError.http(let statusCode, let data) {
            print("Caught HTTP error with status code: \(statusCode) and data: \(String(describing: data))")
            XCTAssertEqual(errorCode, statusCode, "The HTTP status code should match the expected error code.")
            return
        }
        XCTFail("The test should have caught an HTTP error.")
    }
    
    // Test fetching data successfully from a network request
    func testFetch_Success() async throws {
        let expectedRecipeWrapper = try! RecipeItemWrapper.sampleNull()
        session = MockSession(
            data: Recipe.sampleNullJSON,
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.ok,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        
        let fetchedRecipeWrapper: RecipeItemWrapper = try await network.fetch(from: NetworkURL.base, headers: [:])
        XCTAssertEqual(fetchedRecipeWrapper, expectedRecipeWrapper, "The fetched recipe wrapper should match the expected wrapper.")
    }
    
    // Test handling an unexpected response status code
    func testFetch_UnexpectedResponse() async throws {
        session = MockSession(
            data: Recipe.sampleJSON,
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.noContent,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        
        do {
            let _: RecipeItemWrapper = try await network.fetch(from: NetworkURL.base, headers: [:])
        } catch NetworkError.unexpectedResponse(_) {
            print("Caught unexpected response with status code")
            return
        }
        XCTFail("The test should have caught an unexpected response error.")
    }
    
    // Test handling a data parsing error
    func testFetch_ParsingError() async throws {
        session = MockSession(
            data: Data(),
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.ok,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        
        do {
            let _: RecipeItemWrapper = try await network.fetch(from: NetworkURL.base, headers: [:])
        } catch DecodingError.dataCorrupted(let context) {
            print("Caught data parsing error: \(context.debugDescription)")
            return
        }
        XCTFail("The test should have caught a data parsing error.")
    }
}
