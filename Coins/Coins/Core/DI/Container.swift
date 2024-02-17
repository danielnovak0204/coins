//
//  Container.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

final class Container {
    private var services = [String: Any]()
    
    func register<Service>(_ type: Service.Type, factory: @escaping (Container) -> Service) {
        let key = String(describing: type)
        services[key] = factory(self)
    }
    
    func resolve<Service>(_ type: Service.Type) -> Service? {
        let key = String(describing: type)
        return services[key] as? Service
    }
}
