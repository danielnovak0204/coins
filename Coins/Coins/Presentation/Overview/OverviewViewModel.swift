//
//  OverviewViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 18/02/2024.
//

import Foundation

protocol OverviewViewModelProtocol: ObservableObject {
    nonisolated var isFailed: Bool { get set }
    nonisolated var currencies: [CurrencyEntity] { get }
    nonisolated var errorMessage: String { get }
    nonisolated var isLoading: Bool { get }
    
    func fetchCurrencies() async
}

@MainActor
class OverviewViewModel: OverviewViewModelProtocol {
    @Published var isFailed = false
    @Published private(set) var currencies = [CurrencyEntity]()
    @Published private(set) var errorMessage = ""
    @Published private(set) var isLoading = false
    private let getCurrenciesUseCase: GetCurrenciesUseCase
    
    init(getCurrenciesUseCase: GetCurrenciesUseCase) {
        self.getCurrenciesUseCase = getCurrenciesUseCase
    }
    
    func fetchCurrencies() async {
        isLoading = true
        do {
            currencies = try await getCurrenciesUseCase.getCurrencies()
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
