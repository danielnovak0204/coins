//
//  ApiDataSourceImplementationTests.swift
//  CoinsTests
//
//  Created by Dániel Novák on 18/02/2024.
//

import XCTest
@testable import Coins

final class ApiDataSourceImplementationTests: XCTestCase {
    private let apiDataSource = resolveMock(ApiDataSource.self)
    
    func test_Given_Response_When_Get_Currencies_Then_Returns_Items() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesResponse")
        
        _ = try await apiDataSource.getCurrencies()
        XCTAssert(true)
    }
    
    func test_Given_Error_Response_When_Get_Currencies_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 400, json: "GetCurrenciesErrorResponse")
        
        do {
            _ = try await apiDataSource.getCurrencies()
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Response_When_Get_Currency_Then_Returns_Item() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrencyResponse")
        
        _ = try await apiDataSource.getCurrency(id: "ethereum")
        XCTAssert(true)
    }
    
    func test_Given_Error_Response_When_Get_Currency_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 404, json: "GetCurrencyErrorResponse")
        
        do {
            _ = try await apiDataSource.getCurrency(id: "ethereu")
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}

