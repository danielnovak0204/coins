//
//  OverviewViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 18/02/2024.
//

import Foundation

@MainActor
protocol OverviewViewModelProtocol: ObservableObject {
    var isFailed: Bool { get set }
    var currencies: [CurrencyEntity] { get }
    var errorMessage: String { get }
    var isLoading: Bool { get }
    
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
        isFailed = false
        errorMessage = ""
        
        let useCase = getCurrenciesUseCase
        do {
            currencies = try await Task {
                try await useCase.getCurrencies()
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
