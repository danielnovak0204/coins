//
//  RepositoryImplementationTests.swift
//  CoinsTests
//
//  Created by Dániel Novák on 18/02/2024.
//

import XCTest
@testable import Coins

final class RepositoryImplementationTests: XCTestCase {
    private let repository = resolveMock(Repository.self)
    
    func test_Given_Response_When_Get_Currencies_Then_Returns_Items() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesResponse")
        
        _ = try await repository.getCurrencies()
        XCTAssert(true)
    }
    
    func test_Given_Error_Response_When_Get_Currencies_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 400, json: "GetCurrenciesErrorResponse")
        
        do {
            _ = try await repository.getCurrencies()
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Invalid_Data_Response_When_Get_Currencies_Then_Throws_Map_Model_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesInvalidDataResponse")
        
        do {
            _ = try await repository.getCurrencies()
            XCTAssert(false)
        } catch RepositoryError.mapModel {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Response_When_Get_Currency_Then_Returns_Item() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrencyResponse")
        
        _ = try await repository.getCurrency(id: "ethereum")
        XCTAssert(true)
    }
    
    func test_Given_Error_Response_When_Get_Currency_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 404, json: "GetCurrencyErrorResponse")
        
        do {
            _ = try await repository.getCurrency(id: "ethereu")
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Invalid_Data_Response_When_Get_Currency_Then_Throws_Map_Model_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrencyInvalidDataResponse")
        
        do {
            _ = try await repository.getCurrency(id: "ethereum")
            XCTAssert(false)
        } catch RepositoryError.mapModel {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}
