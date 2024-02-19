//
//  CircleAsyncImage.swift
//  Coins
//
//  Created by Dániel Novák on 19/02/2024.
//

import SwiftUI

struct CircleAsyncImage: View {
    let url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.gray
                .opacity(0.5)
        }
        .clipShape(Circle())
    }
}

#Preview {
    CircleAsyncImage(url: previewCurrencies.first!.iconUrl)
}
