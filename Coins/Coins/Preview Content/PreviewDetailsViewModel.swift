//
//  PreviewDetailsViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

class PreviewDetailsViewModel: DetailsViewModelProtocol {
    var isFailed = false
    var currencyDetails = previewCurrencies.first!.details
    var errorMessage = ""
    var isLoading = false
    
    func fetchCurrencyDetails() async {
        // No action required.
    }
}
