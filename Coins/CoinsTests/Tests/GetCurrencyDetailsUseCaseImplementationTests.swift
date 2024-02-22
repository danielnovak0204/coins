//
//  GetCurrencyDetailsUseCaseImplementationTests.swift
//  CoinsTests
//
//  Created by Dániel Novák on 21/02/2024.
//

import XCTest
@testable import Coins

final class GetCurrencyDetailsUseCaseImplementationTests: XCTestCase {
    private let getCurrencyDetailsUseCase = resolveMock(GetCurrencyUseCase.self)
    
    func test_Given_Response_When_Get_Currency_Details_Then_Returns_Item() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrencyDetailsResponse")
        
        _ = try await getCurrencyDetailsUseCase.getCurrencyDetails(id: "ethereum")
        XCTAssert(true)
    }
    
    func test_Given_Error_Response_When_Get_Currency_Details_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 404, json: "GetCurrencyDetailsErrorResponse")
        
        do {
            _ = try await getCurrencyDetailsUseCase.getCurrencyDetails(id: "ethereu")
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}
