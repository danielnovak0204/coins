//
//  Container+Data.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

extension Container {
    func withDataComponents() -> Self {
        register(RequestBuilder.self) { _ in
            RequestBuilderImplementation()
        }
        register(ApiDataSource.self) {
            ApiDataSourceImplementation(requestBuilder: $0.resolve(RequestBuilder.self)!)
        }
        return self
    }
}
