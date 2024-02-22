//
//  DetailsView.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import SwiftUI

private enum Constants {
    static let priceTitle = "Price"
    static let change24HrTitle = "Change (24hr)"
    static let marketCapTitle = "Market Cap"
    static let volume24HrTitle = "Volume (24hr)"
    static let supplyTitle = "Supply"
    static let errorTitle = "Error"
    static let retryTitle = "Retry"
}

struct DetailsView<ViewModel: DetailsViewModelProtocol>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var isProgressVisible = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(spacing: 32) {
                VStack(spacing: 24) {
                    AmountView(title: Constants.priceTitle, amount: viewModel.currency.priceUsd)
                    
                    ChangePercentView(
                        title: Constants.change24HrTitle,
                        changePercent: viewModel.currency.changePercent24Hr,
                        changePercentColor: viewModel.currency.isChangePercent24HrNegative ? .appRed : .appGreen
                    )
                }
                
                Divider()
                    .frame(height: 1)
                    .overlay(.appBlue)
                
                VStack(spacing: 24) {
                    AmountView(title: Constants.marketCapTitle, amount: viewModel.currency.marketCapUsd)
                    
                    AmountView(title: Constants.volume24HrTitle, amount: viewModel.currency.volumeUsd24Hr)
                    
                    AmountView(title: Constants.supplyTitle, amount: viewModel.currency.supply)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(24)
            .background(.appWhite.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(content: progressView)
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text(viewModel.currency.name)
                        .font(.poppinsBold(size: 32))
                        .foregroundStyle(.appBlack)
                        .padding(.leading, 20)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    CircleAsyncImage(url: viewModel.currency.iconUrl)
                        .frame(height: 40)
                }
            }
            .alert(Constants.errorTitle, isPresented: $viewModel.isFailed) {
                Button(Constants.retryTitle) {
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
