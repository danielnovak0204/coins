//
//  GetCurrencyUseCase.swift
//  Coins
//
//  Created by Dániel Novák on 20/02/2024.
//

protocol GetCurrencyUseCase {
    func getCurrency(id: String) async throws -> CurrencyEntity
}

class GetCurrencyUseCaseImplementation: GetCurrencyUseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getCurrency(id: String) async throws -> CurrencyEntity {
        try await repository.getCurrency(id: id)
    }
}
