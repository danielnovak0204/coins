//
//  Double+Extension.swift
//  Coins
//
//  Created by Dániel Novák on 19/02/2024.
//

extension Double {
    var asPercentString: String {
        String(format: "%.2f%%", self)
    }
    
    var asAbbreviatedString: String {
        let abbreviations = ["", "K", "M", "B", "T"]
        var value = self
        var index = 0
        while value >= 1000 && index < abbreviations.count - 1 {
            value /= 1000
            index += 1
        }
        return String(format: "%.2f\(abbreviations[index])", value)
    }
}
