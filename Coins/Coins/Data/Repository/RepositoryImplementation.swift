//
//  RepositoryImplementation.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

class RepositoryImplementation: Repository {
    private enum Constants {
        static let iconUrlPath = "https://assets.coincap.io/assets/icons/"
        static let iconUrlResourceType = "@2x.png"
    }
    
    private let apiDataSource: ApiDataSource
    
    init(apiDataSource: ApiDataSource) {
        self.apiDataSource = apiDataSource
    }
    
    func getCurrencies() async throws -> [CurrencyEntity] {
        let currencies = try await apiDataSource.getCurrencies()
        return currencies.map { currency in
            CurrencyEntity(
                id: currency.id,
                iconUrl: Constants.iconUrlPath + currency.symbol.lowercased() + Constants.iconUrlResourceType,
                name: currency.name.uppercased(),
                symbol: currency.symbol.uppercased(),
                priceUsd: currency.priceUsd,
                changePercent24Hr: currency.changePercent24Hr
            )
        }
    }
}
