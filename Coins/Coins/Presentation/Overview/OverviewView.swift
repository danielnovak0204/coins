//
//  OverviewView.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

import SwiftUI

struct OverviewView<ViewModel: OverviewViewModelProtocol>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var isProgressVisible = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                ScrollView {
                    ForEach(viewModel.currencies) {
                        CurrencyView(entity: $0)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                    }
                    .opacity(isProgressVisible ? 0 : 1)
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
                .onChange(of: viewModel.isLoading) { _, newValue in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isProgressVisible = newValue
                    }
                }
            }
        }
        .overlay {
            if isProgressVisible {
                ProgressView()
                    .transition(.opacity)
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
