//
//  OverviewView.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

import SwiftUI

struct OverviewView<ViewModel: OverviewViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    LinearGradient(
                        colors: [.appBackgroundCyan, .appBackgroundPurple],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                    
                    ScrollView {
                        ForEach(viewModel.currencies) {
                            CurrencyView(entity: $0)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                        }
                        .opacity(viewModel.isLoading ? 0 : 1)
                        .animation(.easeInOut(duration: 0.2), value: viewModel.isLoading)
                    }
                    .scrollIndicators(.never)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Text("COINS")
                                .font(.poppinsBold(size: 32))
                                .foregroundStyle(.appBlack)
                        }
                    }
                    .toolbarBackground(.appBackgroundCyan, for: .navigationBar)
                    .alert("Error", isPresented: $viewModel.isFailed) {
                        Button("Retry") {
                            fetchCurrencies()
                        }
                    } message: {
                        Text(viewModel.errorMessage)
                    }
                    .onAppear {
                        fetchCurrencies()
                    }
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
    
    private func fetchCurrencies() {
        Task {
            await viewModel.fetchCurrencies()
        }
    }
}

#Preview {
    OverviewView(viewModel: PreviewOverviewViewModel())
}
