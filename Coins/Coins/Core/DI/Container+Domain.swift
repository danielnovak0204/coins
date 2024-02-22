//
//  Container+Domain.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

extension Container {
    func withDomainComponents() -> Self {
        register(Repository.self) {
            RepositoryImplementation(apiDataSource: $0.resolve(ApiDataSource.self)!)
        }
        register(GetCurrenciesUseCase.self) {
            GetCurrenciesUseCaseImplementation(repository: $0.resolve(Repository.self)!)
        }
        register(GetCurrencyUseCase.self) {
            GetCurrencyUseCaseImplementation(repository: $0.resolve(Repository.self)!)
        }
        return self
    }
}
