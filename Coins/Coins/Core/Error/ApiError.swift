//
//  ApiError.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

enum ApiError: AppError {
    case configuration
    case decoding
    case noConnection
    case request
    case unknown
}

extension ApiError {
    private enum Constants {
        static let configurationErrorMessage = "Configuration error"
        static let decodingErrorMessage = "Decoding error"
        static let noConnectionErrorMessage = "No connection"
        static let requestErrorMessage = "Request failed"
        static let unknownErrorMessage = "Unknown error"
    }
    
    var message: String {
        switch self {
        case .configuration: Constants.configurationErrorMessage
        case .decoding: Constants.decodingErrorMessage
        case .noConnection: Constants.noConnectionErrorMessage
        case .request: Constants.requestErrorMessage
        case .unknown: Constants.unknownErrorMessage
        }
    }
}
