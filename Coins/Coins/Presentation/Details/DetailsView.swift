//
//  DetailsView.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import SwiftUI

struct DetailsView<ViewModel: DetailsViewModelProtocol>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var isProgressVisible = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 32) {
                VStack(spacing: 24) {
                    AmountView(title: "Price", amount: viewModel.currency.priceUsd)
                    
                    ChangePercentView(
                        title: "Change (24hr)",
                        changePercent: viewModel.currency.changePercent24Hr,
                        changePercentColor: viewModel.currency.isChangePercent24HrNegative ? .appRed : .appGreen
                    )
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(.appBlue)
                
                VStack(spacing: 24) {
                    AmountView(title: "Market Cap", amount: viewModel.currency.marketCapUsd)
                    
                    AmountView(title: "Volume (24hr)", amount: viewModel.currency.volumeUsd24Hr)
                    
                    AmountView(title: "Supply", amount: viewModel.currency.supply)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(24)
            .background(.appWhite.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(content: progressView)
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .alert("Error", isPresented: $viewModel.isFailed) {
                Button("Retry") {
                    fetchCurrencyDetails()
                }
            } message: {
                Text(viewModel.errorMessage)
            }
            .onAppear {
                fetchCurrencyDetails()
            }
            .onChange(of: viewModel.isLoading) { _, newValue in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isProgressVisible = newValue
                }
            }
        }
    }
    
    @ViewBuilder
    private func progressView() -> some View {
        if isProgressVisible {
            RoundedRectangle(cornerRadius: 16)
                .fill(.appWhite.opacity(0.7))
                .transition(.opacity)
            ProgressView()
                .transition(.opacity)
        }
    }
    
    private func fetchCurrencyDetails() {
        Task {
            await viewModel.fetchCurrency()
        }
    }
}

#Preview {
    DetailsView(viewModel: PreviewDetailsViewModel())
}
