//
//  CurrencyEntity.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

struct CurrencyEntity: Identifiable {
    let id: String
    let iconUrl: String
    let name: String
    let symbol: String
    let details: CurrencyDetailsEntity
}
