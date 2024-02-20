//
//  GetCurrencyDetailsUseCase.swift
//  Coins
//
//  Created by Dániel Novák on 20/02/2024.
//

protocol GetCurrencyDetailsUseCase {
    func getCurrencyDetails(id: String) async throws -> CurrencyDetailsEntity
}

class GetCurrencyDetailsUseCaseImplementation: GetCurrencyDetailsUseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func getCurrencyDetails(id: String) async throws -> CurrencyDetailsEntity {
        try await repository.getCurrencyDetails(id: id)
    }
}
