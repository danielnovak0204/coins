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
        return try currencies.map {
            try map(currency: $0)
        }
    }
    
    func getCurrency(id: String) async throws -> CurrencyEntity {
        let currency = try await apiDataSource.getCurrency(id: id)
        return try map(currency: currency)
    }
    
    private func map(currency: Currency) throws -> CurrencyEntity {
        guard let supply = Double(currency.supply),
              let marketCapUsd = Double(currency.marketCapUsd),
              let volumeUsd24Hr = Double(currency.volumeUsd24Hr),
              let priceUsd = Double(currency.priceUsd),
              let changePercent24Hr = Double(currency.changePercent24Hr) else {
            throw RepositoryError.mapModel
        }
        return CurrencyEntity(
            id: currency.id,
            symbol: currency.symbol.uppercased(),
            iconUrl: Constants.iconUrlPath + currency.symbol.lowercased() + Constants.iconUrlResourceType,
            name: currency.name.uppercased(),
            supply: supply.asAbbreviatedString,
            marketCapUsd: "$\(marketCapUsd.asAbbreviatedString)",
            volumeUsd24Hr: "$\(volumeUsd24Hr.asAbbreviatedString)",
            priceUsd: "$\(priceUsd.asAbbreviatedString)",
            changePercent24Hr: changePercent24Hr.asPercentString,
            isChangePercent24HrNegative: changePercent24Hr < 0
        )
    }
}
