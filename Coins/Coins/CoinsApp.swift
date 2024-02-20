//
//  CoinsApp.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

import SwiftUI

@main
struct CoinsApp: App {
    var body: some Scene {
        WindowGroup {
            OverviewView(
                viewModel: OverviewViewModel(
                    getCurrenciesUseCase: Resolver.shared.resolve(GetCurrenciesUseCase.self)
                )
            )
        }
    }
}
