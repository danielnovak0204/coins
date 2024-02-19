//
//  AppError.swift
//  Coins
//
//  Created by Dániel Novák on 19/02/2024.
//

protocol AppError: Error {
    var message: String { get }
}
