//
//  CurrencyEntity.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

struct CurrencyEntity: Identifiable {
    let id: String
    let symbol: String
    let iconUrl: String
    let name: String
    let supply: String
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let priceUsd: String
    let changePercent24Hr: String
    let isChangePercent24HrNegative: Bool
}
