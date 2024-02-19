//
//  PreviewOverviewViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 18/02/2024.
//

class PreviewOverviewViewModel: OverviewViewModelProtocol {
    var isFailed = false
    var currencies = [CurrencyEntity]()
    var errorMessage = ""
    var isLoading = false
    
    func fetchCurrencies() async {
        // No action required.
    }
}
