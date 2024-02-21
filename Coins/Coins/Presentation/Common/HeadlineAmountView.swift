//
//  HeadlineAmountView.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import SwiftUI

struct HeadlineAmountView: View {
    let title: String
    let amount: String
    
    var body: some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.poppinsBold(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(amount)
                .font(.poppinsBold(size: 16))
        }
        .frame(height: 14)
    }
}

#Preview {
    HeadlineAmountView(
        title: previewCurrencies.first!.name,
        amount: previewCurrencies.first!.details.priceUsd
    )
}
