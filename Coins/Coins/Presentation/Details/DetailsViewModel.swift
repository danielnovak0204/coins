//
//  DetailsViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import Foundation

protocol DetailsViewModelProtocol: ObservableObject {
    nonisolated var isFailed: Bool { get set }
    nonisolated var currencyDetails: CurrencyDetailsEntity { get }
    nonisolated var errorMessage: String { get }
    nonisolated var isLoading: Bool { get }
    
    func fetchCurrencyDetails() async
}

@MainActor
class DetailsViewModel: DetailsViewModelProtocol {
    @Published var isFailed = false
    @Published private(set) var currencyDetails: CurrencyDetailsEntity
    @Published private(set) var errorMessage = ""
    @Published private(set) var isLoading = false
    private let currencyId: String
    private let getCurrencyDetailsUseCase: GetCurrencyDetailsUseCase
    
    init(
        currencyId: String,
        currencyDetails: CurrencyDetailsEntity,
        getCurrencyDetailsUseCase: GetCurrencyDetailsUseCase
    ) {
        self.currencyId = currencyId
        self.currencyDetails = currencyDetails
        self.getCurrencyDetailsUseCase = getCurrencyDetailsUseCase
    }
    
    func fetchCurrencyDetails() async {
        isLoading = true
        do {
            currencyDetails = try await getCurrencyDetailsUseCase.getCurrencyDetails(id: currencyId)
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
