//
//  GetCurrenciesUseCaseImplementationTests.swift
//  CoinsTests
//
//  Created by Dániel Novák on 18/02/2024.
//

import XCTest
@testable import Coins

final class GetCurrenciesUseCaseImplementationTests: XCTestCase {
    private let getCurrenciesUseCase = resolveMock(GetCurrenciesUseCase.self)
    
    func test_Given_Response_When_Get_Currencies_Then_Returns_Items() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesResponse")
        
        _ = try await getCurrenciesUseCase.getCurrencies()
        XCTAssert(true)
    }
    
    func test_Given_Error_Response_When_Get_Currencies_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 400, json: "GetCurrenciesErrorResponse")
        
        do {
            _ = try await getCurrenciesUseCase.getCurrencies()
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}
