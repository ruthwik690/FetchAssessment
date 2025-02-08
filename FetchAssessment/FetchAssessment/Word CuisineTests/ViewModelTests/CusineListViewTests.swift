//
//  CusineListViewTests.swift
//  Word Cuisine
//
//  Created by Dipak Panchasara on 04/02/25.
//

import Word_Cuisine
import XCTest
import SwiftUI
import Combine

final class CusineListViewTests: XCTestCase {
    
    private var session: Session!
    private var network: Network!
    private var viewModel: CusineListView.ViewModel!

    override func tearDownWithError() throws {
        session = nil
        network = nil
        viewModel = nil
    }
    
    /// Test if fetch meals successfully processes the network response
    func testFetchRecipe_Success() async throws {
        session = MockSession(
            data: RecipeItemWrapper.sampleJSON,
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.ok,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        await viewModel.fetchRecipes()
        
        switch (viewModel.state) {
        case .success(let received):
            XCTAssertEqual(received.count, 5, "Only one meal is expected after cleaning")
            print("✅ Fetch operation succeeded")
        case .loading:
            XCTFail("ViewState should not be in loading state")
        case .failure(let message):
            XCTFail("ViewState should not be in failure state: \(message)")
        }
    }
    
    /// Test if fetch meals successfully cleans the network response
    func testFetchRecipe_Empty() async throws {
        session = MockSession(
            data: RecipeItemWrapper.sampleNullJSON,
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.ok,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        await viewModel.fetchRecipes()
        
        switch (viewModel.state) {
        case .success(let received):
            XCTAssertTrue(received.isEmpty, "Zero meals are expected after cleaning")
        case .loading:
            XCTFail("ViewState should not be in loading state")
        case .failure(let message):
            XCTFail("ViewState should not be in failure state: \(message)")
        }
    }
    
    /// Test if fetch meals successfully catches the network error
    func testFetchMeals_NetworkError() async throws {
        session = MockSession(
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.errors.lowerBound,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        await viewModel.fetchRecipes()
        
        switch (viewModel.state) {
        case .failure(let message):
            XCTAssertEqual(message, "Please try again after some time", "Should return a network error")
        case .success(_):
            XCTFail("ViewState should not be in success state")
        case .loading:
            XCTFail("ViewState should not be in loading state")
        }
    }
    
    /// Test if fetch meals successfully catches the parsing error
    func testFetchReceipes_ParsingError() async throws {
        session = MockSession(
            response: HTTPURLResponse(
                url: NetworkURL.base,
                statusCode: Http.Status.ok,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        await viewModel.fetchRecipes()
        
        switch (viewModel.state) {
        case .failure(let message):
            XCTAssertEqual(message, "The data couldn’t be read because it isn’t in the correct format.", "Should return a network error")
        case .success(_):
            XCTFail("ViewState should not be in success state")
        case .loading:
            XCTFail("ViewState should not be in loading state")
        }
    }

    /// Test if fetch meals successfully catches the unexpected error
    func testFetchRecipe_UnexpectedError() async throws {
        session = MockSession(error: MockError())
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        await viewModel.fetchRecipes()
        
        switch (viewModel.state) {
        case .failure(_):
            return
        case .success(_):
            XCTFail("ViewState should not be in success state")
        case .loading:
            XCTFail("ViewState should not be in loading state")
        }
    }
    
    /// Test sorting meals by name in ascending order
    func testFiltered_SortMeals_ByName_Ascending() async throws {
        let meals = RecipeItemWrapper.sample.recipes
        session = MockSession()
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        let expected = meals.sorted { $0.name < $1.name }
        viewModel.result = meals
        await viewModel.sortBy(key: .name, order: .ascending)
        
        XCTAssertEqual(viewModel.recipes, expected, "Sorted meals should match")
    }
    
    /// Test sorting meals by name in descending order
    func testFiltered_SortMeals_ByName_Descending() async throws {
        let meals = RecipeItemWrapper.sample.recipes
        session = MockSession()
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        let expected = meals.sorted { $0.name > $1.name }
        viewModel.result = meals
        await viewModel.sortBy(key: .name, order: .descending)
        
        XCTAssertEqual(viewModel.recipes, expected, "Sorted meals should match")
    }
    
    /// Test sorting meals by id in ascending order
    func testFiltered_SortMeals_ById_Ascending() async throws {
        let meals = RecipeItemWrapper.sample.recipes
        session = MockSession()
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        
        let expected = meals.sorted { $0.id < $1.id }
        viewModel.result = meals
        await viewModel.sortBy(key: .id, order: .ascending)
        
        XCTAssertEqual(viewModel.recipes, expected, "Sorted meals should match")
    }
    
    /// Test sorting meals by id in descending order
    func testFiltered_SortMeals_ById_Descending() async throws {
        let meals = RecipeItemWrapper.sample.recipes
        session = MockSession()
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        viewModel.searchText.removeAll()
        
        let expected = meals.sorted { $0.id > $1.id }
        viewModel.result = meals
        await viewModel.sortBy(key: .id, order: .descending)
        
        XCTAssertEqual(viewModel.recipes, expected, "Sorted meals should match")
    }

    
    /// Test if filtered method returns the same list of meals when search text is empty
    func testFiltered_SearchTextIsEmpty() async throws {
        let meals = RecipeItemWrapper.sample.recipes
        session = MockSession()
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        viewModel.searchText.removeAll()
        
        let expected = meals.first!
        viewModel.result = meals
        await viewModel.filter()
        
        XCTAssertEqual(viewModel.recipes.first, expected, "Filtered meals should match")
    }
    
    /// Test if filtered method returns all meals containing the search text
    func testFiltered_SearchTextIsNotEmpty() async throws {
        let meals = RecipeItemWrapper.sample.recipes
        session = MockSession()
        network = MockNetworkProvider(session: session)
        viewModel = CusineListView.ViewModel(network: network)
        viewModel.searchText = "Apple"
        
        viewModel.result = meals
        await viewModel.filter()
        
        XCTAssertEqual(viewModel.recipes.count, 2, "After filtering the meals count should be 2")
        XCTAssertTrue(
            viewModel.recipes.allSatisfy { $0.name.localizedCaseInsensitiveContains("Apple")},
            "All meals should contain the search text"
        )
    }
}
