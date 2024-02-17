//
//  MockResolver.swift
//  CoinsTests
//
//  Created by Dániel Novák on 17/02/2024.
//

@testable import Coins

private let container = Container().withMockComponents()

func resolveMock<Service>(_ type: Service.Type) -> Service {
    container.resolve(type.self)!
}
