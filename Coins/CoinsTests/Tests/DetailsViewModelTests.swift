//
//  DetailsViewModelTests.swift
//  CoinsTests
//
//  Created by Dániel Novák on 21/02/2024.
//

import Combine
import XCTest
@testable import Coins

@MainActor
final class DetailsViewModelTests: XCTestCase {
    private let viewModel = DetailsViewModel(
        currencyId: "ethereum",
        currencyDetails: CurrencyDetailsEntity(
            supply: "120.16M",
            marketCapUsd: "$348.38B",
            volumeUsd24Hr: "$13.80B",
            priceUsd: "$2.79K",
            changePercent24Hr: "-0.20%",
            isChangePercent24HrNegative: true
        ),
        getCurrencyDetailsUseCase: resolveMock(GetCurrencyUseCase.self)
    )
    private var cancellables = Set<AnyCancellable>()
    
    func test_Given_Response_When_Fetch_Currency_Details_Then_Loading_State_Changes() async {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrencyDetailsResponse")
        
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
        
        await viewModel.fetchCurrencyDetails()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Given_Response_When_Fetch_Currency_Details_Then_Item_State_Changes() async {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrencyDetailsResponse")
        
        let expectation = expectation(description: "Item should change")
        
        viewModel.$currencyDetails
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await viewModel.fetchCurrencyDetails()
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    func test_Given_Error_Response_When_Fetch_Currency_Details_Then_Error_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 404, json: "GetCurrencyDetailsErrorResponse")
        
        await viewModel.fetchCurrencyDetails()
        XCTAssert(viewModel.isFailed)
    }
    
    func test_Given_Error_Response_When_Fetch_Currency_Details_Then_Error_Message_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 404, json: "GetCurrencyDetailsErrorResponse")
        
        await viewModel.fetchCurrencyDetails()
        XCTAssert(!viewModel.errorMessage.isEmpty)
    }
    
    func test_Given_Invalid_Data_Response_When_Fetch_Currency_Details_Then_Error_Message_State_Changes() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrencyDetailsInvalidDataResponse")
        
        await viewModel.fetchCurrencyDetails()
        XCTAssert(!viewModel.errorMessage.isEmpty)
    }
}
