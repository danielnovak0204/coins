//
//  Double+Extension.swift
//  Coins
//
//  Created by Dániel Novák on 19/02/2024.
//

import SwiftUI

extension Double {
    var signBasedColor: Color {
        self < 0 ? .appRed : .appGreen
    }
    
    var asPercentString: String {
        String(format: "%.2f%%", self)
    }
    
    var asAbbreviatedPriceString: String {
        let abbreviations = ["", "K", "M", "B", "T"]
        var value = self
        var index = 0
        while value >= 1000 && index < abbreviations.count - 1 {
            value /= 1000
            index += 1
        }
        return String(format: "$%.2f\(abbreviations[index])", value)
    }
}
