//
//  DetailsViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import Foundation

@MainActor
protocol DetailsViewModelProtocol: ObservableObject {
    var isFailed: Bool { get set }
    var currency: CurrencyEntity { get }
    var errorMessage: String { get }
    var isLoading: Bool { get }
    
    func fetchCurrency() async
}

@MainActor
class DetailsViewModel: DetailsViewModelProtocol {
    @Published var isFailed = false
    @Published private(set) var currency: CurrencyEntity
    @Published private(set) var errorMessage = ""
    @Published private(set) var isLoading = false
    private let getCurrencyUseCase: GetCurrencyUseCase
    
    init(currency: CurrencyEntity, getCurrencyUseCase: GetCurrencyUseCase) {
        self.currency = currency
        self.getCurrencyUseCase = getCurrencyUseCase
    }
    
    func fetchCurrency() async {
        isLoading = true
        isFailed = false
        errorMessage = ""
        
        let useCase = getCurrencyUseCase
        do {
            currency = try await Task {
                try await useCase.getCurrency(id: currency.id)
            }.value
        } catch let error as AppError {
            errorMessage = error.message
            isFailed = true
        } catch {
            errorMessage = error.localizedDescription
            isFailed = true
        }
        isLoading = false
    }
}
