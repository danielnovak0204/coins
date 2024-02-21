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
        return try currencies.map { currency in
            guard let supply = Double(currency.supply),
                  let marketCapUsd = Double(currency.marketCapUsd),
                  let volumeUsd24Hr = Double(currency.volumeUsd24Hr),
                  let priceUsd = Double(currency.priceUsd),
                  let changePercent24Hr = Double(currency.changePercent24Hr) else {
                throw RepositoryError.mapModel
            }
            return CurrencyEntity(
                id: currency.id,
                iconUrl: Constants.iconUrlPath + currency.symbol.lowercased() + Constants.iconUrlResourceType,
                name: currency.name.uppercased(),
                symbol: currency.symbol.uppercased(),
                details: CurrencyDetailsEntity(
                    supply: supply.asAbbreviatedString,
                    marketCapUsd: "$\(marketCapUsd.asAbbreviatedString)",
                    volumeUsd24Hr: "$\(volumeUsd24Hr.asAbbreviatedString)",
                    priceUsd: "$\(priceUsd.asAbbreviatedString)",
                    changePercent24Hr: changePercent24Hr.asPercentString,
                    isChangePercent24HrNegative: changePercent24Hr < 0
                )
            )
        }
    }
    
    func getCurrencyDetails(id: String) async throws -> CurrencyDetailsEntity {
        let currencyDetails = try await apiDataSource.getCurrencyDetails(id: id)
        guard let supply = Double(currencyDetails.supply),
              let marketCapUsd = Double(currencyDetails.marketCapUsd),
              let volumeUsd24Hr = Double(currencyDetails.volumeUsd24Hr),
              let priceUsd = Double(currencyDetails.priceUsd),
              let changePercent24Hr = Double(currencyDetails.changePercent24Hr) else {
            throw RepositoryError.mapModel
        }
        return CurrencyDetailsEntity(
            supply: supply.asAbbreviatedString,
            marketCapUsd: "$\(marketCapUsd.asAbbreviatedString)",
            volumeUsd24Hr: "$\(volumeUsd24Hr.asAbbreviatedString)",
            priceUsd: "$\(priceUsd.asAbbreviatedString)",
            changePercent24Hr: changePercent24Hr.asPercentString,
            isChangePercent24HrNegative: changePercent24Hr < 0
        )
    }
}
