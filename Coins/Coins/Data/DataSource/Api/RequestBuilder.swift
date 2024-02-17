//
//  RequestBuilder.swift
//  Coins
//
//  Created by Dániel Novák on 17/02/2024.
//

protocol RequestBuilder {
    func withUrl(_ url: String) -> Self
    func withType(_ type: HTTPMethod) -> Self
    func withTimeout(_ timeout: Double) -> Self
    func withQueryParameter(key: QueryKey, value: String) -> Self
    func withQueryParameters(_ queryParameters: [QueryKey: String]) -> Self
    func withHeaderParameter(key: HeaderKey, value: String) -> Self
    func withHeaderParameters(_ headerParameters: [HeaderKey: String]) -> Self
    func request<T: Decodable>() async throws -> T
}

enum HTTPMethod: String {
    case get = "GET"
}

enum QueryKey: String {
    case limit
}

enum HeaderKey: String {
    case acceptEncoding = "Accept-Encoding"
}
