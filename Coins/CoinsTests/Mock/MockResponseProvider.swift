//
//  MockResponseProvider.swift
//  CoinsTests
//
//  Created by Dániel Novák on 17/02/2024.
//

import XCTest
@testable import Coins

class MockResponseProvider {
    static func provideMockResponse(statusCode: Int, json resource: String) {
        guard let jsonPath = Bundle(for: Self.self).path(forResource: resource, ofType: "json") else {
            XCTFail("MockResponseProvider: failed to get json resource path")
            return
        }
        guard let jsonData = try? String(contentsOfFile: jsonPath).data(using: .utf8) else {
            XCTFail("MockResponseProvider: failed to get data from json resource")
            return
        }
        MockURLProtocol.responseProvider = { request in
            guard let url = request.url, let response = HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            ) else {
                XCTFail("MockResponseProvider: failed to provide mock response")
                throw ApiError.unknown
            }
            return (response, jsonData)
        }
    }
}
