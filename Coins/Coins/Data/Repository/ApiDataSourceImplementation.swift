//
//  ApiDataSourceImplementation.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

class ApiDataSourceImplementation: ApiDataSource {
    private enum Constants {
        static let apiBaseUrl = "https://api.coincap.io/v2"
        static let assetsUrlPath = "/assets"
        static let limitQueryParameterValue = "10"
        static let acceptEncodingHeaderParameterValue = "gzip"
        static let requestTimeout = 10.0
    }
    
    private let requestBuilder: RequestBuilder
    
    init(requestBuilder: RequestBuilder) {
        self.requestBuilder = requestBuilder
            .withHeaderParameter(key: .acceptEncoding, value: Constants.acceptEncodingHeaderParameterValue)
            .withTimeout(Constants.requestTimeout)
    }
    
    func getCurrencies() async throws -> [Currency] {
        let currenciesWrapper: CurrenciesWrapper = try await requestBuilder
            .withType(.get)
            .withUrl(Constants.apiBaseUrl + Constants.assetsUrlPath)
            .withQueryParameter(key: .limit, value: Constants.limitQueryParameterValue)
            .request()
        return currenciesWrapper.data
    }
}
