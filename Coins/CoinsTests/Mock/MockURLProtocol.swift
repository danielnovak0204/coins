//
//  MockURLProtocol.swift
//  CoinsTests
//
//  Created by Dániel Novák on 17/02/2024.
//

import Foundation
import XCTest

final class MockURLProtocol: URLProtocol {
    static var responseProvider: ((URLRequest) throws -> (URLResponse, Data?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let responseProvider = MockURLProtocol.responseProvider else {
            XCTFail("MockURLProtocol: responseProvider not set")
            return
        }
        
        do {
            let (response, data) = try responseProvider(request)
            MockURLProtocol.responseProvider = nil
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        // No action required.
    }
}
