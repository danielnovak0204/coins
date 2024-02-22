//
//  ChangePercentView.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import SwiftUI

struct ChangePercentView: View {
    let title: String
    let changePercent: String
    let changePercentColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.poppinsRegular(size: 16))
                .foregroundStyle(.appBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(changePercent)
                .font(.poppinsBold(size: 16))
                .foregroundStyle(changePercentColor)
        }
        .frame(height: 11)
    }
}

#Preview {
    ChangePercentView(
        title: previewCurrencies.first!.symbol,
        changePercent: previewCurrencies.first!.changePercent24Hr,
        changePercentColor: .appRed
    )
}
