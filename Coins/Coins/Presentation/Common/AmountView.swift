//
//  AmountView.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import SwiftUI

struct AmountView: View {
    let title: String
    let amount: String
    
    var body: some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.poppinsRegular(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(amount)
                .font(.poppinsBold(size: 16))
        }
        .frame(height: 14)
    }
}

#Preview {
    AmountView(
        title: "Volume (24hr)",
        amount: previewCurrencies.first!.details.volumeUsd24Hr
    )
}
