//
//  GetCurrenciesUseCase.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

protocol GetCurrenciesUseCase {
    func getCurrencies() async throws -> [CurrencyEntity]
}

class GetCurrenciesUseCaseImplementation: GetCurrenciesUseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getCurrencies() async throws -> [CurrencyEntity] {
        try await repository.getCurrencies()
    }
}
