//
//  Resolver.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

final class Resolver {
    static let shared = Resolver()
    private var container: Container!
    
    private init() {
        // No action required.
    }
    
    func resolve<Service>(_ type: Service.Type) -> Service {
        ensureContainer()
        return container.resolve(type.self)!
    }
    
    private func ensureContainer() {
        if container == nil {
            container = Container()
                .withDataComponents()
                .withDomainComponents()
        }
    }
}
