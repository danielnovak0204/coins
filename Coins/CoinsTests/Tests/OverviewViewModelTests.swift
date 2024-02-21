//
//  OverviewViewModelTests.swift
//  CoinsTests
//
//  Created by Dániel Novák on 18/02/2024.
//

import Combine
import XCTest
@testable import Coins

@MainActor
final class OverviewViewModelTests: XCTestCase {
    private let viewModel = OverviewViewModel(
        getCurrenciesUseCase: resolveMock(GetCurrenciesUseCase.self)
    )
    private var cancellables = Set<AnyCancellable>()
    
    func test_Given_Response_When_Fetch_Currencies_Then_Loading_State_Changes() async {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesResponse")
        
        var isLoadingTrueCount = 0
        var isLoadingFalseCount = 0
        let expectation = expectation(description: "Loading should be indicated while fetching currencies")
        
        viewModel.$isLoading
            .dropFirst()
            .sink { isLoading in
                if isLoading {
                    isLoadingTrueCount += 1
                } else {
                    isLoadingFalseCount += 1
                }
                XCTAssertLessThanOrEqual(isLoadingTrueCount, 1)
                XCTAssertLessThanOrEqual(isLoadingFalseCount, 1)
                if isLoadingTrueCount == 1 && isLoadingFalseCount == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        await viewModel.fetchCurrencies()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Given_Response_When_Fetch_Currencies_Then_Items_State_Changes() async {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesResponse")
        
        let expectation = expectation(description: "Items should change")
        
        viewModel.$currencies
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.fetchCurrencies()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Given_Error_Response_When_Fetch_Currencies_Then_Error_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 400, json: "GetCurrenciesErrorResponse")
        
        await viewModel.fetchCurrencies()
        XCTAssert(viewModel.isFailed)
    }
    
    func test_Given_Error_Response_When_Fetch_Currencies_Then_Error_Message_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 400, json: "GetCurrenciesErrorResponse")
        
        await viewModel.fetchCurrencies()
        XCTAssert(!viewModel.errorMessage.isEmpty)
    }
    
    func test_Given_Invalid_Data_Response_When_Fetch_Currencies_Then_Error_Message_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesInvalidDataResponse")
        
        await viewModel.fetchCurrencies()
        XCTAssert(!viewModel.errorMessage.isEmpty)
    }
}
