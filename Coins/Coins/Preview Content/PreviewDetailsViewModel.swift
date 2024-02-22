//
//  PreviewDetailsViewModel.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

class PreviewDetailsViewModel: DetailsViewModelProtocol {
    var isFailed = false
    var currency = previewCurrencies.first!
    var errorMessage = ""
    var isLoading = false
    
    func fetchCurrency() async {
        // No action required.
    }
}
