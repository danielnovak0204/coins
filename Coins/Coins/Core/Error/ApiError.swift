//
//  ApiError.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

enum ApiError: Error {
    case configuration
    case decoding
    case noConnection
    case request
    case unknown
}
