//
//  RepositoryError.swift
//  Coins
//
//  Created by Dániel Novák on 19/02/2024.
//

enum RepositoryError: AppError {
    case mapModel
}

extension RepositoryError {
    private enum Constants {
        static let mapModelErrorMessage = "Map model failed"
    }
    
    var message: String {
        switch self {
        case .mapModel: return Constants.mapModelErrorMessage
        }
    }
}
