//
//  CurrencyDetails.swift
//  Coins
//
//  Created by Dániel Novák on 20/02/2024.
//

struct CurrencyDetails: Decodable {
    let supply: String
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let priceUsd: String
    let changePercent24Hr: String
}
