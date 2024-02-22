//
//  BackgroundView.swift
//  Coins
//
//  Created by Dániel Novák on 21/02/2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [.appBackgroundCyan, .appBackgroundPurple],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
