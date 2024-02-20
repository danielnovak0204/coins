//
//  ApiDataSource.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

protocol ApiDataSource {
    func getCurrencies() async throws -> [Currency]
    func getCurrencyDetails(id: String) async throws -> CurrencyDetails
}
