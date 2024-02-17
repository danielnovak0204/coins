//
//  Currency.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

struct Currency: Decodable {
    let id: String
    let name: String
    let symbol: String
    let priceUsd: String
    let changePercent24Hr: String
}
