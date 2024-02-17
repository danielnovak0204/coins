//
//  RequestBuilderImplementationTests.swift
//  CoinsTests
//
//  Created by Dániel Novák on 17/02/2024.
//

import XCTest
@testable import Coins

final class RequestBuilderImplementationTests: XCTestCase {
    private let requestBuilder = resolveMock(RequestBuilder.self)

    func test_Given_Parameters_When_Request_Then_Returns_Items() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesResponse")
        
        let _: CurrenciesWrapper = try await requestBuilder
            .withType(.get)
            .withUrl("https://api.coincap.io/v2/assets")
            .withHeaderParameter(key: .acceptEncoding, value: "gzip")
            .withQueryParameter(key: .limit, value: "10")
            .withTimeout(10)
            .request()
        XCTAssert(true)
    }
    
    func test_Given_Empty_Url_When_Request_Then_Throws_Configuration_Error() async throws {
        do {
            let _: CurrenciesWrapper = try await requestBuilder
                .withType(.get)
                .withUrl("")
                .withHeaderParameter(key: .acceptEncoding, value: "gzip")
                .withQueryParameter(key: .limit, value: "10")
                .withTimeout(10)
                .request()
            XCTAssert(false)
        } catch ApiError.configuration {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Error_Response_When_Request_Then_Throws_Request_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 400, json: "GetCurrenciesErrorResponse")
        
        do {
            let _: CurrenciesWrapper = try await requestBuilder
                .withType(.get)
                .withUrl("https://api.coincap.io/v2/assets")
                .withHeaderParameter(key: .acceptEncoding, value: "gzip")
                .withQueryParameter(key: .limit, value: "2001")
                .withTimeout(10)
                .request()
            XCTAssert(false)
        } catch ApiError.request {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
    
    func test_Given_Incorrect_Response_When_Request_Then_Throws_Decoding_Error() async throws {
        MockResponseProvider.provideMockResponse(statusCode: 200, json: "GetCurrenciesIncorrectResponse")
        
        do {
            let _: CurrenciesWrapper = try await requestBuilder
                .withType(.get)
                .withUrl("https://api.coincap.io/v2/assets")
                .withHeaderParameter(key: .acceptEncoding, value: "gzip")
                .withQueryParameter(key: .limit, value: "10")
                .withTimeout(10)
                .request()
            XCTAssert(false)
        } catch ApiError.decoding {
            XCTAssert(true)
        } catch {
            XCTAssert(false)
        }
    }
}
