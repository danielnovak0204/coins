//
//  DetailsViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import Foundation

protocol DetailsViewModelProtocol: ObservableObject {
    nonisolated var isFailed: Bool { get set }
    nonisolated var currency: CurrencyEntity { get }
    nonisolated var errorMessage: String { get }
    nonisolated var isLoading: Bool { get }
    
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
        do {
            currency = try await getCurrencyUseCase.getCurrency(id: currency.id)
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
