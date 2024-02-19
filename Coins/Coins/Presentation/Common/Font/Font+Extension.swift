//
//  Font+Extension.swift
//  Coins
//
//  Created by Dániel Novák on 19/02/2024.
//

import SwiftUI

extension Font {
    static func poppinsRegular(size: CGFloat) -> Font {
        custom("Poppins-Regular", size: size)
    }
    
    static func poppinsBold(size: CGFloat) -> Font {
        custom("Poppins-Bold", size: size)
    }
}
