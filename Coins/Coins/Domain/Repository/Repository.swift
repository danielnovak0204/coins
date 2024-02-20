//
//  Repository.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

protocol Repository {
    func getCurrencies() async throws -> [CurrencyEntity]
    func getCurrencyDetails(id: String) async throws -> CurrencyDetailsEntity
}
