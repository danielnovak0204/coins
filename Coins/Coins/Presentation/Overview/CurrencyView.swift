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
                HStack(spacing: 20) {
                    Text(entity.name)
                        .font(.poppinsBold(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(entity.priceUsd.asAbbreviatedPriceString)
                        .font(.poppinsBold(size: 16))
                }
                .frame(height: 14)
                
                HStack(spacing: 20) {
                    Text(entity.symbol)
                        .font(.poppinsRegular(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(entity.changePercent24Hr.asPercentString)
                        .font(.poppinsBold(size: 16))
                        .foregroundStyle(entity.changePercent24Hr.signBasedColor)
                }
                .frame(height: 11)
                
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
