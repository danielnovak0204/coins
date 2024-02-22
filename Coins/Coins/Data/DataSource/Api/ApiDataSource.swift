//
//  ApiDataSource.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

protocol ApiDataSource {
    func getCurrencies() async throws -> [Currency]
    func getCurrency(id: String) async throws -> Currency
}
