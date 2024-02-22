//
//  CurrencyView.swift
//  Coins
//
//  Created by Dániel Novák on 18/02/2024.
//

import SwiftUI

struct CurrencyView: View {
    let entity: CurrencyEntity
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            CircleAsyncImage(url: entity.iconUrl)
                .frame(width: 56)
            
            VStack(spacing: 16) {
                HeadlineAmountView(title: entity.name, amount: entity.priceUsd)
                
                ChangePercentView(
                    title: entity.symbol,
                    changePercent: entity.changePercent24Hr,
                    changePercentColor: entity.isChangePercent24HrNegative ? .appRed : .appGreen
                )
                
                HStack {
                    Spacer()
                    
                    Image(.arrow)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                }
            }
            .foregroundStyle(.appBlack)
        }
        .padding(.leading, 12)
        .padding(.vertical, 16)
        .padding(.trailing, 16)
        .background(.appWhite.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CurrencyView(entity: previewCurrencies.first!)
        .preferredColorScheme(.dark)
}
